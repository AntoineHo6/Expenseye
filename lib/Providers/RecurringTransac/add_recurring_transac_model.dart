import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Models/recurring_transac.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRecurringTransacModel extends ChangeNotifier {
  int step = 1;
  String name;
  double amount;
  DateTime startingDay;
  Periodicity periodicity;
  String categoryId;
  TransacType type;
  bool isNameInvalid = false;
  bool isAmountInvalid = false;

  AddRecurringTransacModel();

  void goNextFromTypePage(TransacType type) {
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

  void createRecurringTransac(BuildContext context) {
    RecurringTransac newRecurringTransac = new RecurringTransac(
      this.name,
      this.amount,
      this.startingDay,
      this.categoryId,
      periodicity,
    );
    Provider.of<DbModel>(context, listen: false)
        .insertRecurringTransac(newRecurringTransac);

    Provider.of<DbModel>(context, listen: false).initCheckRecurringTransacs();
    Navigator.pop(context);
  }
}
