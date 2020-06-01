import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Models/recurrent_item.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRecurrentItemModel extends ChangeNotifier {
  int step = 1;
  String name;
  double amount;
  DateTime startingDay;
  Periodicity periodicity;
  String category;
  ItemType type;
  bool isNameInvalid = false;
  bool isAmountInvalid = false;

  AddRecurrentItemModel();

  void goNextFromTypePage(ItemType type) {
    this.type = type;
    step++;
    notifyListeners();
  }

  void goNextFromPeriodicityPage(Periodicity periodicity) {
    this.periodicity = periodicity;
    step++;
    notifyListeners();
  }

  void goNextFromDatePage(DateTime startingDay) {
    this.startingDay = DateTimeUtil.timeToZeroInDate(startingDay);
    step++;
    notifyListeners();
  }

  void goNextFromNameAmountPage(String name, String amount) {
    bool areFieldsInvalid = _checkFieldsInvalid(name, amount);

    if (!areFieldsInvalid) {
      step++;
      notifyListeners();
    }
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

  void createRecurrentItem(BuildContext context) {
    RecurrentItem newRecurrentItem = new RecurrentItem(this.name, this.amount,
        this.startingDay, this.category, periodicity);
    Provider.of<DbModel>(context, listen: false)
        .insertRecurrentItem(newRecurrentItem);
    Navigator.pop(context);
  }
}
