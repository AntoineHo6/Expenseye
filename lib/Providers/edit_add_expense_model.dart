import 'package:expense_app/Pages/EditAdd/categories_page.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:flutter/material.dart';

class EditAddExpenseModel extends ChangeNotifier {
  bool didInfoChange = false;

  bool isNameInvalid = false;
  bool isPriceInvalid = false;

  DateTime date;
  ExpenseCategory category;

  EditAddExpenseModel(this.date, this.category);

  // Will make the save button clickable
  void infoChanged(String text) {
    didInfoChange = true;
    notifyListeners();
  }

  // Will make the save button clickable
  void updateDate(DateTime newDate) {
    if (newDate != null) {
      date = newDate;
      infoChanged(null);
    }
  }

  /// Will check and show error msg if a field is invalid.
  bool checkFieldsInvalid({String name, String price}) {
    // check NAME field
    isNameInvalid = name.isEmpty ? true : false;

    // check PRICE field
    try {
      double.parse(price);
      isPriceInvalid = false;
    } on FormatException {
      isPriceInvalid = true;
    }

    notifyListeners();

    // update areFieldsInvalid
    if (!isNameInvalid && !isPriceInvalid) {
      return false;
    }
    return true;
  }

  /// On selected category in the CategoriesPage, update the current category
  /// in the model
  void openCategoriesPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoriesPage(),
      ),
    );

    // TODO: make this a seperate function
    if (result != null) {
      category = result;
      infoChanged(null);
    }
  }
}
