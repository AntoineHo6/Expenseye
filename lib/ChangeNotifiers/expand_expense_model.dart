import 'package:flutter/material.dart';

class ExpandExpenseModel extends ChangeNotifier {
  bool didInfoChange = false;

  bool isNameInvalid = false;
  bool isPriceInvalid = false;
  bool areFieldsInvalid = false;

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
}
