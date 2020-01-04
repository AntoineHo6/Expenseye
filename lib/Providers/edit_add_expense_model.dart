import 'package:expense_app/expense_category.dart';
import 'package:flutter/material.dart';

class EditAddExpenseModel extends ChangeNotifier {
  bool didInfoChange = false;

  bool isNameInvalid = false;
  bool isPriceInvalid = false;

  DateTime date;
  ExpenseCategory category;

  EditAddExpenseModel(this.date, this.category);

  void infoChanged(String text) {
    didInfoChange = true;
    notifyListeners();
  }

  void updateDate(DateTime newDate) {
    if (newDate != null) {
      date = newDate;
      infoChanged(null);
    }
  }

  // Will check and show error msg if a field is invalid
  bool checkFieldsInvalid({String name, String price, DateTime date}) {
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
    } else {
      return true;
    }
  }
}

// TODO: ShowDatePicker should be in components
