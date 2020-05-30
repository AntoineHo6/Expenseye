import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';

class AddRecurrentItemModel extends ChangeNotifier {
  int step = 1;
  String name;
  double amount;
  DateTime startingDay;
  bool isNameInvalid = false;
  bool isAmountInvalid = false;
  ItemType type;

  AddRecurrentItemModel(this.type);

  void goNextFromNameAmountPage(String name, String amount) {
    bool areFieldsInvalid = _checkFieldsInvalid(name, amount);

    if (!areFieldsInvalid) {
      this.step++;
      notifyListeners();
    }
  }

  void goNextFromDatePage(DateTime startingDay) {
    this.startingDay = DateTimeUtil.timeToZeroInDate(startingDay);
    this.step++;
    notifyListeners();
  }

  // Will check and show error msg if a field is invalid.
  bool _checkFieldsInvalid(String name, String amount) {
    // check NAME field
    this.isNameInvalid = name.isEmpty ? true : false;

    // check PRICE field
    try {
      double.parse(amount);
      this.isAmountInvalid = false;
    } on FormatException {
      this.isAmountInvalid = true;
    }

    notifyListeners();

    // update areFieldsInvalid
    if (!isNameInvalid && !isAmountInvalid) {
      this.name = name;
      this.amount = double.parse(amount);
      return false;
    }
    return true;
  }
}
