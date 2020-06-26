import 'package:Expenseye/Components/Global/confirmation_dialog.dart';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Pages/EditAddTransac/choose_category_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/settings_notifier.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTransacModel extends ChangeNotifier {
  bool didInfoChange = false;
  bool isNameInvalid = false;
  bool isAmountInvalid = false;
  DateTime date;
  String categoryId;
  TransacType type;

  EditTransacModel(Transac item) {
    date = item.date;
    categoryId = item.categoryId;
    type = item.type;
  }

  // Will make the save button clickable
  void infoChanged(String text) {
    didInfoChange = true;
    notifyListeners();
  }

  Future<void> chooseDate(BuildContext context, DateTime initialDate) async {
    DateTime newDate = await DateTimeUtil.chooseDate(
      context,
      initialDate,
      Provider.of<SettingsNotifier>(context, listen: false).getTheme(),
    );
    if (newDate != null) {
      date = newDate;
      infoChanged(null);
    }
  }

  Future<void> editItem(
    BuildContext context,
    int id,
    String newName,
    String newAmount,
  ) async {
    newName = newName.trim();
    bool areFieldsInvalid = _checkFieldsInvalid(newName, newAmount);

    // if all the fields are valid, update and quit
    if (!areFieldsInvalid) {
      Transac newItem = new Transac.withId(
          id, newName, double.parse(newAmount), date, type, categoryId);

      await Provider.of<DbModel>(context, listen: false).editItem(newItem);
      Navigator.pop(context, 1);
    }
  }

  Future<void> delete(BuildContext context, int expenseId) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        AppLocalizations.of(context).translate('confirmDeleteMsg'),
      ),
    );

    if (confirmed != null && confirmed) {
      Provider.of<DbModel>(context, listen: false).deleteItem(expenseId);
      Navigator.pop(context, 2);
    }
  }

  /// On selected category in the ChooseCategoryPage, update the current category
  /// in the model
  Future<void> openChooseCategoryPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseCategoryPage(type: type),
      ),
    );

    if (result != null) {
      categoryId = result;
      infoChanged(null);
    }
  }

  // Will check and show error msg if a field is invalid.
  bool _checkFieldsInvalid(String newName, String newAmount) {
    // check NAME field
    isNameInvalid = newName.isEmpty ? true : false;

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
}
