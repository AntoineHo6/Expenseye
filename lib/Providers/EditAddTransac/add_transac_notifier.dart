import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Pages/EditAddTransac/choose_account_page.dart';
import 'package:Expenseye/Pages/EditAddTransac/choose_category_page.dart';
import 'package:Expenseye/Providers/Global/db_notifier.dart';
import 'package:Expenseye/Providers/Global/settings_notifier.dart';
import 'package:Expenseye/Utils/check_textfields_util.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransacNotifier extends ChangeNotifier {
  bool isNameInvalid = false;
  bool isAmountInvalid = false;
  bool isCategoryMissingError = false;

  DateTime date;
  TransacType type;
  String categoryId;
  String accountId;

  AddTransacNotifier(this.date, this.type, this.accountId);

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

    // newName = newName.trim();
    bool areFieldsInvalid = _checkFieldsInvalid(newName, newAmount);
    _checkCategoryInvalid();

    // if all the fields are valid, add and quit
    if (!areFieldsInvalid && !isCategoryMissingError) {
      Transac newTransac = new Transac(
        newName,
        (double.parse(newAmount)).abs(),
        newDate,
        type,
        categoryId,
        accountId,
      );

      await Provider.of<DbNotifier>(context, listen: false).insertTransac(newTransac);
      Provider.of<DbNotifier>(context, listen: false).notifyListeners();

      String lastUsedAccountId =
          Provider.of<SettingsNotifier>(context, listen: false).getLastUsedAccountId();
      if (accountId != lastUsedAccountId) {
        Provider.of<SettingsNotifier>(context, listen: false).setLastUsedAccountId(accountId);
      }

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

  Future<void> openChooseAccountPage(BuildContext context) async {
    final newAccountId = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseAccountPage(),
      ),
    );

    if (newAccountId != null) {
      accountId = newAccountId;
      notifyListeners();
    }
  }

  /// Will check and show error msg if a field is invalid.
  bool _checkFieldsInvalid(String newName, String newAmount) {
    isNameInvalid = CheckTextFieldsUtil.isStringInvalid(newName);

    isAmountInvalid = CheckTextFieldsUtil.isNumberStringInvalid(newAmount);

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
