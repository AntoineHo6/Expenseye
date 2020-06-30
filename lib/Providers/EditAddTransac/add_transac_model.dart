import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Pages/EditAddTransac/choose_category_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/settings_notifier.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransacModel extends ChangeNotifier {
  bool isNameInvalid = false;
  bool isAmountInvalid = false;
  bool isCategoryMissingError = false;

  DateTime date;
  TransacType type;
  String categoryId;
  String accountId = DbModel.defaultAccountId;

  AddTransacModel(this.date, this.type);

  // Will make the save button clickable
  void updateDate(DateTime newDate) {
    if (newDate != null) {
      date = newDate;
      notifyListeners();
    }
  }

  void chooseDate(BuildContext context, DateTime initialDate) async {
    DateTime newDate = await DateTimeUtil.chooseDate(
      context,
      initialDate,
      Provider.of<SettingsNotifier>(context, listen: false).getTheme(),
    );
    updateDate(newDate);
  }

  Future<void> addTransac(BuildContext context, String newName, String newAmount) async {
    // make sure to remove time before adding to db
    final DateTime newDate = DateTimeUtil.timeToZeroInDate(date);

    bool areFieldsInvalid = _checkFieldsInvalid(newName, newAmount);
    _checkCategoryInvalid();

    // if all the fields are valid, add and quit
    if (!areFieldsInvalid && !isCategoryMissingError) {
      Transac newTransac = new Transac(
        newName,
        double.parse(newAmount),
        newDate,
        type,
        categoryId,
        accountId,
      );

      await Provider.of<DbModel>(context, listen: false).addTransac(newTransac);
      Navigator.pop(context);
    }
  }

  /// On selected category in the ChooseCategoryPage, update the current category
  /// in the model
  void openChooseCategoryPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseCategoryPage(type: type),
      ),
    );

    if (result != null) {
      categoryId = result;
      _checkCategoryInvalid();
      notifyListeners();
    }
  }

  /// Will check and show error msg if a field is invalid.
  bool _checkFieldsInvalid(String newName, String newAmount) {
    // check NAME field
    isNameInvalid = newName.trim().isEmpty ? true : false;

    // check AMOUNT field
    try {
      double.parse(newAmount);
      isAmountInvalid = false;
    } on FormatException {
      isAmountInvalid = true;
    }

    notifyListeners();

    // update areFieldsInvalid
    if (!isNameInvalid && !isAmountInvalid) {
      return false;
    }
    return true;
  }

  void _checkCategoryInvalid() {
    if (categoryId == null) {
      isCategoryMissingError = true;
    } else {
      isCategoryMissingError = false;
    }
  }
}
