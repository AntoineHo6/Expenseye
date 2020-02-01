import 'package:Expenseye/Components/EditAdd/add_item_dialog.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Pages/EditAdd/edit_expense_page.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/database_helper.dart';
import 'package:Expenseye/Utils/item_category.dart';
import 'package:Expenseye/google_firebase_helper.dart';
import 'package:flutter/material.dart';

class ItemModel extends ChangeNotifier {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  ItemModel() {
    initConnectedUser();
    initCategoriesMap();
  }

  void initConnectedUser() async {
    await GoogleFirebaseHelper.initConnectedUser();
  }

  void initCategoriesMap() async {
    List<Category> categories = await dbHelper.queryCategories();
    for (var category in categories) {
      Categories.map[category.id] = category;
    }
  }

  Future<void> loginWithGoogle() async {
    List<Item> localItems = await dbHelper.queryAllItems();

    bool isLoggedIn = await GoogleFirebaseHelper.loginWithGoogle();

    //if (isLoggedIn && localItems.length > 0) {
    if (isLoggedIn) {
      for (Item item in localItems) {
        await dbHelper.insertItem(item);
      }
    }

    try{
        await dbHelper.upgrade();
      }
      catch(e) {}
    
    try{
        await dbHelper.upgrade();
      }
      catch(e) {}

    notifyListeners();
  }

  Future<void> logOutFromGoogle() async {
    await GoogleFirebaseHelper.uploadDbFile();
    await GoogleFirebaseHelper.logOut();
    await dbHelper.deleteAll();
    notifyListeners();
  }

  void addItem(Item newItem) async {
    await dbHelper.insertItem(newItem);
    notifyListeners();
  }

  void editItem(Item newItem) async {
    await dbHelper.updateItem(newItem);
    notifyListeners();
  }

  void deleteItem(int id) async {
    await dbHelper.deleteItem(id);
    notifyListeners();
  }

  void showAddExpense(BuildContext context, DateTime initialDate) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => AddItemDialog(initialDate, ItemType.expense),
    );

    if (confirmed != null && confirmed) {
      showSuccAddedSnackBar(context);
    }
  }

  void showAddIncome(BuildContext context, DateTime initialDate) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => AddItemDialog(initialDate, ItemType.income),
    );

    if (confirmed != null && confirmed) {
      showSuccAddedSnackBar(context);
    }
  }

  void showSuccAddedSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(Strings.succAdded),
      backgroundColor: Colors.grey.withOpacity(0.5),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  void openEditItem(BuildContext context, Item item) async {
    int action = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditExpensePage(item)),
    );

    if (action != null) {
      final snackBar = SnackBar(
        content:
            action == 1 ? Text(Strings.succEdited) : Text(Strings.succDeleted),
        backgroundColor: Colors.grey.withOpacity(0.5),
      );

      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void calcTotals(dynamic model, List<Item> items) {
    double total = 0;
    double expenseTotal = 0;
    double incomeTotal = 0;

    for (var item in items) {
      switch (item.type) {
        case ItemType.expense:
          expenseTotal += item.value;
          total -= item.value;
          break;
        case ItemType.income:
          incomeTotal += item.value;
          total += item.value;
          break;
      }
    }

    model.currentTotal = total;
    model.currentExpenseTotal = expenseTotal;
    model.currentIncomeTotal = incomeTotal;

    //notifyListeners();
  }

  double calcItemsTotal(List<Item> items) {
    double total = 0;

    for (var item in items) {
      switch (item.type) {
        case ItemType.expense:
          total -= item.value;
          break;
        case ItemType.income:
          total += item.value;
          break;
      }
    }

    return total;
  }

  // * may move out of this provider
  String totalString(double total) {
    return '${total.toStringAsFixed(2)} \$';
  }
}
