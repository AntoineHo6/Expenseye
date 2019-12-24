import 'package:flutter/material.dart';

class ExpandExpenseBloc extends ChangeNotifier {
  bool didInfoChange = false;

  bool isTitleInvalid = false;
  bool isPriceInvalid = false;

  bool areFieldsInvalid = false;

  void infoChanged(String text) {
    didInfoChange = true;
    notifyListeners();
  }

  void checkFieldsInvalid(String priceText) {
    //double newPrice;
    try {
      isPriceInvalid = false;
      final newPrice = double.parse(priceText);
    } 
    on FormatException {
      isPriceInvalid = true;
    }

    if (!isPriceInvalid) {
      areFieldsInvalid = false;
    }
    else {
      areFieldsInvalid = true;
    }

    notifyListeners();
  }

  void save() {
    if (!isPriceInvalid) {
      
    }
  }
}
