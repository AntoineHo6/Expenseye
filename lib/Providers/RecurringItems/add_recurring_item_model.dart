import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Models/recurring_item.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRecurringItemModel extends ChangeNotifier {
  int step = 1;
  String name;
  double amount;
  DateTime startingDay;
  Periodicity periodicity;
  Category category;
  ItemType type;
  bool isNameInvalid = false;
  bool isAmountInvalid = false;

  AddRecurringItemModel();

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

    // check AMOUNT field
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

  void createRecurringItem(BuildContext context) {
    RecurringItem newRecurringItem =
        new RecurringItem(name, amount, startingDay, category, periodicity);
    Provider.of<DbModel>(context, listen: false)
        .insertRecurringItem(newRecurringItem);

    Provider.of<DbModel>(context, listen: false).initCheckRecurringItems();
    Navigator.pop(context);
  }
}
