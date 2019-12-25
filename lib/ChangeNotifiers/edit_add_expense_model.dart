import 'package:expense_app_beginner/ChangeNotifiers/Global/expense_model.dart';
import 'package:expense_app_beginner/Models/Expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAddExpenseModel extends ChangeNotifier {
  bool didInfoChange = false;

  bool isNameInvalid = false;
  bool isPriceInvalid = false;
  bool areFieldsInvalid = false;

  // * Only used when adding an expense
  DateTime date;

  void infoChanged(String text) {
    didInfoChange = true;
    notifyListeners();
  }

  void checkFieldsInvalid({String name, String price}) {
    // check NAME field
    isNameInvalid = name.isEmpty ? true : false;

    // check PRICE field
    try {
      double.parse(price);
      isPriceInvalid = false;
    } on FormatException {
      isPriceInvalid = true;
    }

    // update areFieldsInvalid
    if (!isNameInvalid && !isPriceInvalid) {
      areFieldsInvalid = false;
    } else {
      areFieldsInvalid = true;
    }

    notifyListeners();
  }

  void saveEditedExpense(BuildContext context, Expense expense,
      {String name, String price}) {
    // 1. will check and show error msg if a field is invalid
    checkFieldsInvalid(name: name, price: price);

    // 2. if all the fields are valid, update and quit
    if (!areFieldsInvalid) {
      Provider.of<ExpenseModel>(context)
          .editExpense(expense, name: name, price: price);

      Navigator.pop(context);
    }
  }

  void saveAddedExpense(BuildContext context, {String name, String price}) {
    // 1. will check and show error msg if a field is invalid
    checkFieldsInvalid(name: name, price: price);

    // 2. if all the fields are valid, update and quit
    if (!areFieldsInvalid) {
      Provider.of<ExpenseModel>(context).addExpense(name, price);

      Navigator.pop(context);
    }
  }
}
