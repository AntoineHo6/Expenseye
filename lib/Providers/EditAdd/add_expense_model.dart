import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Pages/EditAdd/categories_page.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseModel extends ChangeNotifier {
  bool isNameInvalid = false;
  bool isPriceInvalid = false;

  DateTime date;
  ExpenseCategory category = ExpenseCategory.food;

  AddExpenseModel(this.date);

  // Will make the save button clickable
  void updateDate(DateTime newDate) {
    if (newDate != null) {
      date = newDate;
      notifyListeners();
    }
  }

  void chooseDate(BuildContext context, DateTime initialDate) async {
    DateTime newDate = await DateTimeUtil.chooseDate(context, initialDate);
    updateDate(newDate);
  }

  void addExpense(BuildContext context, String newName, String newPrice) {
    // make sure to remove time before adding to db
    final DateTime newDate = DateTimeUtil.timeToZeroInDate(date);

    bool areFieldsInvalid = _checkFieldsInvalid(newName, newPrice);

    // if all the fields are valid, add and quit
    if (!areFieldsInvalid) {
      Expense newExpense =
          new Expense(newName, double.parse(newPrice), newDate, category);

      Provider.of<ExpenseModel>(context, listen: false).addExpense(newExpense);
      Navigator.pop(context, true);
    }
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

    if (result != null) {
      category = result;
      notifyListeners();
    }
  }

  /// Will check and show error msg if a field is invalid.
  bool _checkFieldsInvalid(String newName, String newPrice) {
    // check NAME field
    isNameInvalid = newName.isEmpty ? true : false;

    // check PRICE field
    try {
      double.parse(newPrice);
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
}