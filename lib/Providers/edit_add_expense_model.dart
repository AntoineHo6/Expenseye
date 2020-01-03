import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';

class EditAddExpenseModel extends ChangeNotifier {
  bool didInfoChange = false;

  bool isNameInvalid = false;
  bool isPriceInvalid = false;

  // * Only used when adding an expense
  DateTime date;

  EditAddExpenseModel(this.date);

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

  void chooseDate(BuildContext context, DateTime initialDate) async {
    DateTime newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            primarySwatch: MyColors.indigoInk,
            splashColor: MyColors.indigoInk
          ),
          child: child,
        );
      },
    );

    updateDate(newDate);
  }
}

// TODO: ShowDatePicker should be in components
