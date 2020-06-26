import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Helpers/google_firebase_helper.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Models/recurring_transac.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class DbModel extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  static Map<String, Category> catMap = new Map();  // used throughtout the app to access category colors, icon and type

  DbModel() {
    initUser();
  }

  Future<void> initUser() async {
    await initConnectedUser();
    await initUserCategoriesMap();
    await initCheckRecurringItems();
  }

  Future<void> loginInit() async {
    List<Transac> localItems = await queryAllItems();
    List<Category> localCategories = await queryCategories();
    List<RecurringTransac> localRecItems = await queryRecurringItems();

    bool isLoggedIn = await loginWithGoogle();
    // * From this point on, the sqflite file contains data from the firebase file
    List<Category> accCategories = await queryCategories();

    if (isLoggedIn) {
      await addLocalItems(localItems, localCategories, localRecItems, accCategories);
    }

    await initUserCategoriesMap();
    await initCheckRecurringItems();
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
    await _deleteAllItems();
    await _resetCategories();
  }

  Future<void> initCheckRecurringItems() async {
    List<RecurringTransac> recurringItems = await queryRecurringItems();
    DateTime today = DateTimeUtil.timeToZeroInDate(DateTime.now());

    for (var recurringItem in recurringItems) {
      // if same date and not added yet
      if (recurringItem.dueDate.compareTo(today) == 0) {
        await insRecItemInstanceAndUpdate(recurringItem);
      }
      // else if recurringItem's date is before today
      else if (recurringItem.dueDate.compareTo(today) == -1) {
        while (recurringItem.dueDate.compareTo(today) != 1) {
          await insRecItemInstanceAndUpdate(recurringItem);
        }
      }
    }

    notifyListeners();
  }

  Future<void> insRecItemInstanceAndUpdate(RecurringTransac recurringItem) async {
    // 1. insert item
    Transac newItem = Transac(
      recurringItem.name,
      recurringItem.amount,
      recurringItem.dueDate,
      catMap[recurringItem.category].type,
      recurringItem.category,
    );
    await _dbHelper.insertItem(newItem);
    // 2. update recurring item's date
    recurringItem.updateDueDate();
    await _dbHelper.updateRecurringItem(recurringItem);
  }

  Future<void> addLocalItems(
    List<Transac> localItems,
    List<Category> localCategories,
    List<RecurringTransac> localRecItems,
    List<Category> accCategories,
  ) async {
    List<String> accCategoriesId =
        accCategories.map((category) => category.id).toList();

    for (var localCategory in localCategories) {
      if (!accCategoriesId.contains(localCategory.id)) {
        await _dbHelper.insertCategory(localCategory);
        catMap[localCategory.id] = localCategory;
      }
    }

    if (localItems.length > 0) {
      for (Transac item in localItems) {
        await _dbHelper.insertItem(item);
      }
    }

    if (localRecItems.length > 0) {
      for (var recItem in localRecItems) {
        await _dbHelper.insertRecurringItem(recItem);
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

  Future<List<Transac>> queryAllItems() async {
    return await _dbHelper.queryAllItems();
  }

  Future<void> addItem(Transac newItem) async {
    await _dbHelper.insertItem(newItem);
    notifyListeners();
  }

  Future<void> editItem(Transac newItem) async {
    await _dbHelper.updateItem(newItem);
    notifyListeners();
  }

  Future<void> deleteItem(int id) async {
    await _dbHelper.deleteItem(id);
    notifyListeners();
  }

  Future<void> _deleteAllItems() async {
    await _dbHelper.deleteAllItems();
    notifyListeners();
  }

  Future<List<Transac>> queryItemsByDay(DateTime day) async {
    DateTime dayClean = DateTimeUtil.timeToZeroInDate(day);
    return await _dbHelper.queryItemsInDate(dayClean);
  }

  Future<List<Transac>> queryItemsByMonth(String yearMonth) async {
    return await _dbHelper.queryItemsByMonth(yearMonth);
  }

  Future<List<Category>> queryCategories() async {
    return await _dbHelper.queryCategories();
  }

  Future<void> deleteCategory(String categoryId) async {
    await _dbHelper.deleteCategory(categoryId);
    await initUserCategoriesMap();
  }

  Future<void> deleteItemsByCategory(String categoryId) async {
    await _dbHelper.deleteItemsByCategory(categoryId);
    notifyListeners();
  }

  Future<void> _resetCategories() async {
    await _dbHelper.deleteAllCategories();
    await _dbHelper.insertDefaultCategories();
    await initUserCategoriesMap();
  }

  Future<List<Transac>> queryItemsInYear(String year) async {
    return await _dbHelper.queryItemsInYear(year);
  }

  Future<void> insertRecurringItem(RecurringTransac recurringItem) async {
    await _dbHelper.insertRecurringItem(recurringItem);
    notifyListeners();
  }

  Future<List<RecurringTransac>> queryRecurringItems() async {
    return await _dbHelper.queryRecurringItems();
  }

  Future<void> editRecurringItem(RecurringTransac recurringItem) async {
    await _dbHelper.updateRecurringItem(recurringItem);
    notifyListeners();
  }

  Future<void> deleteRecurringItem(int id) async {
    await _dbHelper.deleteRecurringItem(id);
    notifyListeners();
  }
}
