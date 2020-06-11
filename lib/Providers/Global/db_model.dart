import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Helpers/google_firebase_helper.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Models/recurring_item.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class DbModel extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  static Map<int, Category> catMap = new Map();

  DbModel() {
    initializeUser();
  }

  Future<void> initializeUser() async {
    await initConnectedUser();
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
    List<RecurringItem> recurringItems = await queryRecurringItems();
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

  Future<void> insRecItemInstanceAndUpdate(RecurringItem recurringItem) async {
    // 1. insert item
    Item newItem = Item(
      recurringItem.name,
      recurringItem.value,
      recurringItem.dueDate,
      catMap[recurringItem.category].type,
      recurringItem.category,
    );
    await _dbHelper.insertItem(newItem);
    // 2. update recurring item's date
    recurringItem.updateDueDate();
    await _dbHelper.updateRecurringItem(recurringItem);
  }

  Future<void> addLocalItems(List<Item> localItems,
      List<Category> localCategories, List<Category> accCategories) async {
    List<int> accCategoriesId =
        accCategories.map((category) => category.id).toList();

    for (var localCategory in localCategories) {
      if (!accCategoriesId.contains(localCategory.id)) {
        await _dbHelper.insertCategory(localCategory);
        catMap[localCategory.id] = localCategory;
      }
    }

    if (localItems.length > 0) {
      for (Item item in localItems) {
        await _dbHelper.insertItem(item);
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

  Future<List<Item>> queryAllItems() async {
    return await _dbHelper.queryAllItems();
  }

  Future<void> addItem(Item newItem) async {
    await _dbHelper.insertItem(newItem);
    notifyListeners();
  }

  Future<void> editItem(Item newItem) async {
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

  Future<List<Item>> queryItemsByDay(DateTime day) async {
    DateTime dayClean = DateTimeUtil.timeToZeroInDate(day);
    return await _dbHelper.queryItemsInDate(dayClean);
  }

  Future<List<Item>> queryItemsByMonth(String yearMonth) async {
    return await _dbHelper.queryItemsByMonth(yearMonth);
  }

  Future<List<Category>> queryCategories() async {
    return await _dbHelper.queryCategories();
  }

  Future<void> deleteCategory(int categoryId) async {
    await _dbHelper.deleteCategory(categoryId);
    await initUserCategoriesMap();
    // notifyListeners();
  }

  Future<void> deleteItemsByCategory(int categoryId) async {
    await _dbHelper.deleteItemsByCategory(categoryId);
    notifyListeners();
  }

  Future<void> _resetCategories() async {
    await _dbHelper.deleteAllCategories();
    await _dbHelper.insertDefaultCategories();
    await initUserCategoriesMap();
    // notifyListeners();
  }

  Future<List<Item>> queryItemsInYear(String year) async {
    return await _dbHelper.queryItemsInYear(year);
  }

  Future<void> insertRecurringItem(RecurringItem recurringItem) async {
    await _dbHelper.insertRecurringItem(recurringItem);
    notifyListeners();
  }

  Future<List<RecurringItem>> queryRecurringItems() async {
    return await _dbHelper.queryRecurringItems();
  }

  Future<void> editRecurringItem(RecurringItem recurringItem) async {
    await _dbHelper.updateRecurringItem(recurringItem);
  }

  Future<void> deleteRecurringItem(int id) async {
    await _dbHelper.deleteRecurringItem(id);
    notifyListeners();
  }
}
