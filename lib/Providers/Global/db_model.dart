import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:flutter/material.dart';

class DbModel extends ChangeNotifier {
  // TODO: make this a private variable
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  static Map<String, Category> catMap = new Map();

  DbModel() {
    initCategoriesMap();
  }

  Future<void> addLocalItems(List<Item> localItems, List<Category> localCategories, List<Category> accCategories) async {
    List<String> accCategoriesId = accCategories.map((category) => category.id).toList();

    if (localItems.length > 0) {
      for (Item item in localItems) {
        if (!accCategoriesId.contains(item.category)) {
          Category missingCategory = localCategories.firstWhere((category) => category.id == item.category);
          await dbHelper.insertCategory(missingCategory);
          catMap[missingCategory.id] = missingCategory;
        }

        await dbHelper.insertItem(item);
      }
    }
    notifyListeners();
  }

  Future<void> initCategoriesMap() async {
    List<Category> categories = await dbHelper.queryCategories();
    catMap.clear();
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

  Future<void> deleteAllItems() async {
    await dbHelper.deleteAllItems();
    notifyListeners();
  }

  Future<List<Item>> queryItemsByMonth(String yearMonth) async {
    return await dbHelper.queryItemsByMonth(yearMonth);
  }

  Future<void> deleteCategory(String categoryId) async {
    await dbHelper.deleteCategory(categoryId);
    await initCategoriesMap();
    notifyListeners();
  }

  Future<void> deleteItemsByCategory(String categoryId) async {
    await dbHelper.deleteItemsByCategory(categoryId);  
    notifyListeners();  
  }

  Future<void> resetCategories() async {
    await dbHelper.deleteAllCategories();
    await dbHelper.insertDefaultCategories();
    await initCategoriesMap();
    notifyListeners();
  }
}
