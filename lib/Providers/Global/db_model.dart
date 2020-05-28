import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Helpers/google_firebase_helper.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Models/recurrent_item.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';

class DbModel extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  static Map<String, Category> catMap = new Map();
  static List<Category> categories = new List();

  DbModel() {
    initConnectedUser();
    initUserCategoriesMap();
  }

  void initConnectedUser() async {
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

  Future<void> addLocalItems(List<Item> localItems,
      List<Category> localCategories, List<Category> accCategories) async {
    List<String> accCategoriesId =
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
    List<Category> categories = await _dbHelper.queryCategories();
    catMap.clear();
    for (var category in categories) {
      catMap[category.id] = category;
    }
  }

  Future<List<Item>> queryAllItems() async {
    return await _dbHelper.queryAllItems();
  }

  Future<List<Category>> queryCategories() async {
    return await _dbHelper.queryCategories();
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

  Future<void> deleteCategory(String categoryId) async {
    await _dbHelper.deleteCategory(categoryId);
    await initUserCategoriesMap();
    notifyListeners();
  }

  Future<void> deleteItemsByCategory(String categoryId) async {
    await _dbHelper.deleteItemsByCategory(categoryId);
    notifyListeners();
  }

  Future<void> _resetCategories() async {
    await _dbHelper.deleteAllCategories();
    await _dbHelper.insertDefaultCategories();
    await initUserCategoriesMap();
    notifyListeners();
  }

  Future<List<Item>> queryItemsInYear(String year) async {
    return await _dbHelper.queryItemsInYear(year);
  }

  Future<void> insertRecurrentItem(RecurrentItem recurrentItem) async {
    await _dbHelper.insertRecurrentItem(recurrentItem);
    notifyListeners();
  }

  Future<List<RecurrentItem>> queryRecurrentItems() async {
    return await _dbHelper.queryRecurrentItems();
  }

  Future<void> deleteRecurrentItem(int id) async {
    await _dbHelper.deleteRecurrentItem(id);
    notifyListeners();
  }
}
