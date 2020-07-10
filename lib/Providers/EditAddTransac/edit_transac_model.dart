import 'package:Expenseye/Components/Global/confirmation_dialog.dart';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Pages/EditAddTransac/choose_account_page.dart';
import 'package:Expenseye/Pages/EditAddTransac/choose_category_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/settings_notifier.dart';
import 'package:Expenseye/Utils/check_textfields_util.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTransacModel extends ChangeNotifier {
  bool didInfoChange = false;
  bool isNameInvalid = false;
  bool isAmountInvalid = false;
  DateTime date;
  TransacType type;
  String categoryId;
  String accountId;

  EditTransacModel(Transac transac) {
    date = transac.date;
    categoryId = transac.categoryId;
    type = transac.type;
    accountId = transac.accountId;
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

  Future<void> editTransac(
    BuildContext context,
    int id,
    String newName,
    String newAmount,
  ) async {
    newName = newName.trim();
    bool areFieldsInvalid = _checkFieldsInvalid(newName, newAmount);

    // if all the fields are valid, update and quit
    if (!areFieldsInvalid) {
      Transac newTransac = new Transac.withId(
        id,
        newName,
        (double.parse(newAmount)).abs(),
        date,
        type,
        categoryId,
        accountId,
      );

      await Provider.of<DbModel>(context, listen: false).updateTransac(newTransac);
      Navigator.pop(context, 1);
    }
  }

  Future<void> delete(BuildContext context, int transacId) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        AppLocalizations.of(context).translate('confirmDeleteMsg'),
      ),
    );

    if (confirmed != null && confirmed) {
      Provider.of<DbModel>(context, listen: false).deleteTransac(transacId);
      Navigator.pop(context, 2);
    }
  }

  /// On selected category in the ChooseCategoryPage, update the current category
  /// in the model
  Future<void> openChooseCategoryPage(BuildContext context) async {
    final newCategoryId = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseCategoryPage(type: type),
      ),
    );

    if (newCategoryId != null) {
      categoryId = newCategoryId;
      infoChanged(null);
    }
  }

  Future<void> openChooseAccountPage(BuildContext context) async {
    final newAccountId = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseAccountPage(),
      ),
    );

    if (newAccountId != null) {
      accountId = newAccountId;
      infoChanged(null);
    }
  }

  // Will check and show error msg if a field is invalid.
  bool _checkFieldsInvalid(String newName, String newAmount) {
    // check NAME field
    isNameInvalid = CheckTextFieldsUtil.isStringInvalid(newName);

    isAmountInvalid = CheckTextFieldsUtil.isNumberStringInvalid(newAmount);

    notifyListeners();

    if (!isNameInvalid && !isAmountInvalid) {
      return false;
    }
    return true;
  }
}
