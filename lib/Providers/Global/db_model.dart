import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:flutter/material.dart';

class DbModel extends ChangeNotifier {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  static Map<String, Category> catMap = new Map();

  DbModel() {
    initCategoriesMap();
  }

  Future<void> initItems(List<Item> localItems) async {
    if (localItems.length > 0) {
      for (Item item in localItems) {
        await dbHelper.insertItem(item);
      }
    }
    notifyListeners();
  }

  Future<void> initCategoriesMap() async {
    List<Category> categories = await dbHelper.queryCategories();
    for (var category in categories) {
      catMap[category.id] = category;
    }
  }

  Future<void> addItem(Item newItem) async {
    await dbHelper.insertItem(newItem);
    notifyListeners();
  }

  Future<void> editItem(Item newItem) async {
    await dbHelper.updateItem(newItem);
    notifyListeners();
  }

  Future<void> deleteItem(int id) async {
    await dbHelper.deleteItem(id);
    notifyListeners();
  }

  Future<void> deleteAll() async {
    await dbHelper.deleteAll();
    notifyListeners();
  }
}
