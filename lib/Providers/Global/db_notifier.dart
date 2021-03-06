import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Helpers/google_firebase_helper.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Models/account.dart';
import 'package:Expenseye/Models/recurring_transac.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class DbNotifier extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  static Map<String, Category> catMap = new Map(); // used to access category colors, icon and type
  static Map<String, Account> accMap = new Map();

  DbNotifier() {
    initUser();
  }

  Future<void> initUser() async {
    await initConnectedUser();
    await initUserCategoriesMap();
    await initUserAccountsMap();
    await initCheckRecurringTransacs();
  }

  Future<void> loginInit() async {
    List<Transac> localTransacs = await queryAllTransacs();
    List<Category> localCategories = await queryCategories();
    List<RecurringTransac> localRecTransacs = await queryRecurringTransacs();
    List<Account> localAccounts = await _dbHelper.queryAccounts();

    bool isLoggedIn = await loginWithGoogle();
    // * From this point on, the sqflite file contains data from the firebase file
    List<Category> accCategories = await queryCategories();
    List<Account> accAccounts = await _dbHelper.queryAccounts();

    if (isLoggedIn) {
      await addLocalTransacs(localTransacs, localCategories, localRecTransacs, accCategories,
          localAccounts, accAccounts);
    }

    await initUserCategoriesMap();
    await initUserAccountsMap();
    await initCheckRecurringTransacs();
  }

  Future<void> initConnectedUser() async {
    await GoogleFirebaseHelper.initConnectedUser();
  }

  Future<bool> loginWithGoogle() async {
    return await GoogleFirebaseHelper.loginWithGoogle();
  }

  Future<void> logOutFromGoogle() async {
    await GoogleFirebaseHelper.uploadDbFile();
    await GoogleFirebaseHelper.logOut();
    await _deleteAllTransacsAndRecTransacs();
    await _resetCategories();
    await _resetAccounts();
  }

  // change word check to update
  Future<void> initCheckRecurringTransacs() async {
    List<RecurringTransac> recurringTransacs = await queryRecurringTransacs();
    DateTime today = DateTimeUtil.timeToZeroInDate(DateTime.now());

    for (var recurringTransac in recurringTransacs) {
      // if same date and not added yet
      if (recurringTransac.dueDate.compareTo(today) == 0) {
        await insRecTransacInstanceAndUpdate(recurringTransac);
      }
      // else if recurringTransac's date is before today
      else if (recurringTransac.dueDate.compareTo(today) == -1) {
        while (recurringTransac.dueDate.compareTo(today) != 1) {
          await insRecTransacInstanceAndUpdate(recurringTransac);
        }
      }
    }

    notifyListeners();
  }

  Future<void> insRecTransacInstanceAndUpdate(RecurringTransac recurringTransac) async {
    // 1. insert transac
    Transac newTransac = Transac(
      recurringTransac.name,
      recurringTransac.amount,
      recurringTransac.dueDate,
      catMap[recurringTransac.categoryId].type,
      recurringTransac.categoryId,
      recurringTransac.accountId,
    );
    await insertTransac(newTransac);
    // 2. update recurring transac's date
    recurringTransac.updateDueDate();
    await _dbHelper.updateRecurringTransac(recurringTransac);
  }

  Future<void> addLocalTransacs(
    List<Transac> localTransacs,
    List<Category> localCategories,
    List<RecurringTransac> localRecTransacs,
    List<Category> accCategories,
    List<Account> localAccounts,
    List<Account> accAccounts,
  ) async {
    // add the categories that dont exist in the users database
    List<String> accCategoriesId = accCategories.map((category) => category.id).toList();
    for (var localCategory in localCategories) {
      if (!accCategoriesId.contains(localCategory.id)) {
        await _dbHelper.insertCategory(localCategory);
        catMap[localCategory.id] = localCategory;
      }
    }

    // add the accounts that dont exist in the users database
    List<String> accAccountsId = accAccounts.map((account) => account.id).toList();
    for (var localAccount in localAccounts) {
      if (!accAccountsId.contains(localAccount.id)) {
        await insertAccount(localAccount);
        accMap[localAccount.id] = localAccount;
      }
    }

    if (localTransacs.length > 0) {
      // get the sqlite_sequence for transactions
      int transacsSeq = await _dbHelper.querySequence(Strings.tableTransacs);
      for (Transac transac in localTransacs) {
        transacsSeq++;
        transac.id = transacsSeq;
        await insertTransac(transac);
      }
    }

    if (localRecTransacs.length > 0) {
      // get the sqlite_sequence for recurring_transacs
      int recTransacsSeq = await _dbHelper.querySequence(Strings.tableRecurringTransacs);
      for (var recTransac in localRecTransacs) {
        recTransacsSeq++;
        recTransac.id = recTransacsSeq;
        await insertRecurringTransac(recTransac);
      }
    }

    notifyListeners();
  }

  Future<void> initUserCategoriesMap() async {
    catMap.clear();
    List<Category> categories = await _dbHelper.queryCategories();
    for (var category in categories) {
      catMap[category.id] = category;
    }

    notifyListeners();
  }

  Future<void> initUserAccountsMap() async {
    accMap.clear();
    List<Account> accounts = await _dbHelper.queryAccounts();
    for (var account in accounts) {
      accMap[account.id] = account;
    }

    notifyListeners();
  }

  Future<List<Transac>> queryAllTransacs() async {
    return await _dbHelper.queryAllTransacs();
  }

  Future<void> insertTransac(Transac newTransac) async {
    await applyTransacsAmountToBalance([newTransac]);
    await _dbHelper.insertTransac(newTransac);
  }

  Future<void> updateTransac(Transac newTransac) async {
    Transac oldTransac = await _dbHelper.queryTransacById(newTransac.id);
    await _dbHelper.removeTransacAmountFromAccBalance(oldTransac);

    await applyTransacsAmountToBalance([newTransac]);

    await _dbHelper.updateTransac(newTransac);
    notifyListeners();
  }

  Future<void> deleteTransac(int transacId) async {
    Transac transac = await _dbHelper.queryTransacById(transacId);
    await _dbHelper.removeTransacAmountFromAccBalance(transac);
    await _dbHelper.deleteTransac(transacId);
    notifyListeners();
  }

  Future<void> _deleteAllTransacsAndRecTransacs() async {
    await _dbHelper.deleteAllTransacsAndRecTransacs();
    notifyListeners();
  }

  Future<List<Transac>> queryTransacsByDay(DateTime day) async {
    DateTime dayClean = DateTimeUtil.timeToZeroInDate(day);
    return await _dbHelper.queryTransacsInDate(dayClean);
  }

  Future<List<Transac>> queryTransacsByMonth(String yearMonth) async {
    return await _dbHelper.queryTransacsByMonth(yearMonth);
  }

  Future<List<Transac>> queryTransacsByAccount(String accountId) async {
    return await _dbHelper.queryTransacsByAccount(accountId);
  }

  Future<List<Category>> queryCategories() async {
    return await _dbHelper.queryCategories();
  }

  Future<void> deleteCategory(String categoryId) async {
    await deleteTransacsByCategory(categoryId);
    await _dbHelper.deleteRecurringTransacsByCategory(categoryId);
    await _dbHelper.deleteCategory(categoryId);
    await initUserCategoriesMap();
  }

  Future<void> deleteTransacsByCategory(String categoryId) async {
    List<Transac> transacs = await _dbHelper.queryTransacsByCategory(categoryId);

    await revertTransacsAmountFromBalance(transacs);

    await _dbHelper.deleteTransacsByCategory(categoryId);
    notifyListeners();
  }

  Future<void> _resetCategories() async {
    await _dbHelper.deleteAllCategories();
    await _dbHelper.insertDefaultCategories();
    await initUserCategoriesMap();
  }

  Future<void> updateCategory(String oldCategoryId, Category updatedCategory) async {
    await _dbHelper.updateTransacsAndRecTransacsCategory(oldCategoryId, updatedCategory.id);
    await _dbHelper.deleteCategory(oldCategoryId);
    await _dbHelper.insertCategory(updatedCategory);
    await initUserCategoriesMap();
  }

  Future<List<Transac>> queryTransacsInYear(String year) async {
    return await _dbHelper.queryTransacsInYear(year);
  }

  Future<void> insertRecurringTransac(RecurringTransac recurringTransac) async {
    await _dbHelper.insertRecurringTransac(recurringTransac);
    notifyListeners();
  }

  Future<List<RecurringTransac>> queryRecurringTransacs() async {
    return await _dbHelper.queryRecurringTransacs();
  }

  Future<void> editRecurringTransac(RecurringTransac recurringTransac) async {
    await _dbHelper.updateRecurringTransac(recurringTransac);
    notifyListeners();
  }

  Future<void> deleteRecurringTransac(int id) async {
    await _dbHelper.deleteRecurringTransac(id);
    notifyListeners();
  }

  Future<List<Account>> queryAccounts() async {
    return await _dbHelper.queryAccounts();
  }

  Future<void> insertAccount(Account account) async {
    await _dbHelper.insertAccount(account);
    notifyListeners();
  }

  Future<void> deleteAccount(String accountId) async {
    await _dbHelper.deleteAccount(accountId);
    notifyListeners();
  }

  Future<void> deleteTransacsByAccount(String accountId) async {
    List<Transac> transacs = await _dbHelper.queryTransacsByAccount(accountId);

    await revertTransacsAmountFromBalance(transacs);

    await _dbHelper.deleteTransacsByAccount(accountId);
  }

  Future<void> applyTransacsAmountToBalance(List<Transac> transacs) async {
    for (var transac in transacs) {
      if (transac.type == TransacType.expense) {
        await _dbHelper.deductFromAccount(transac.accountId, transac.amount);
      } else {
        await _dbHelper.addToAccount(transac.accountId, transac.amount);
      }
    }
  }

  Future<void> revertTransacsAmountFromBalance(List<Transac> transacs) async {
    for (var transac in transacs) {
      if (transac.type == TransacType.expense) {
        await _dbHelper.addToAccount(transac.accountId, transac.amount);
      } else {
        await _dbHelper.deductFromAccount(transac.accountId, transac.amount);
      }
    }
  }

  Future<void> deleteRecurringTransacsByAccount(String accountId) async {
    await _dbHelper.deleteRecurringTransacsByAccount(accountId);
    notifyListeners();
  }

  Future<void> updateAccount(String oldAccountId, Account updatedAccount) async {
    await _dbHelper.updateTransacsAndRecTransacsAccount(oldAccountId, updatedAccount.id);
    await _dbHelper.deleteAccount(oldAccountId);
    await _dbHelper.insertAccount(updatedAccount);
    await initUserAccountsMap();
  }

  Future<void> _resetAccounts() async {
    await _dbHelper.deleteAllAccounts();
    await _dbHelper.insertDefaultAccount();
    await initUserAccountsMap();
  }
}
