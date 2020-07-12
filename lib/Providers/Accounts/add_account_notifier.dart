import 'package:Expenseye/Models/account.dart';
import 'package:Expenseye/Providers/Global/db_notifier.dart';
import 'package:Expenseye/Utils/check_textfields_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAccountNotifier extends ChangeNotifier {
  bool isNameInvalid = false;
  bool isAmountInvalid = false;

  Future<void> addAccount(BuildContext context, String name, String balance) async {
    name = name.trim();
    bool areFieldsInvalid = _checkFieldsInvalid(name, balance);

    if (!areFieldsInvalid) {
      Account account = new Account(
        name.toLowerCase(),
        name,
        double.parse(balance),
      );

      await Provider.of<DbNotifier>(context, listen: false).insertAccount(account);
      await Provider.of<DbNotifier>(context, listen: false).initUserAccountsMap();
      Navigator.pop(context, 1);
    }
  }

  // Will check and show error msg if a field is invalid.
  bool _checkFieldsInvalid(String newName, String newAmount) {
    // check NAME field
    isNameInvalid = CheckTextFieldsUtil.isStringInvalid(newName);

    isAmountInvalid = CheckTextFieldsUtil.isNumberStringInvalid(newAmount);

    notifyListeners();

    // update areFieldsInvalid
    if (!isNameInvalid && !isAmountInvalid) {
      return false;
    }
    return true;
  }
}
