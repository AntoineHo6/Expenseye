import 'package:Expenseye/Components/Global/confirmation_dialog.dart';
import 'package:Expenseye/Components/Global/load_dialog.dart';
import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Models/account.dart';
import 'package:Expenseye/Providers/Global/db_notifier.dart';
import 'package:Expenseye/Providers/Global/settings_notifier.dart';
import 'package:Expenseye/Utils/check_textfields_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAccountNotifier extends ChangeNotifier {
  String accountId;
  bool didInfoChange = false;
  bool isNameInvalid = false;
  bool isAmountInvalid = false;

  EditAccountNotifier(this.accountId);

  // Will make the save button clickable
  void infoChanged(String text) {
    didInfoChange = true;
    notifyListeners();
  }

  Future<void> editAccount(BuildContext context, String newName, String newBalance) async {
    newName = newName.trim();
    bool areFieldsInvalid = _checkFieldsInvalid(newName, newBalance);

    if (!areFieldsInvalid) {
      Account updatedAccount = Account(
        newName.toLowerCase(),
        newName,
        (double.parse(newBalance)).abs(),
      );

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadDialog();
        },
      );

      await Provider.of<DbNotifier>(context, listen: false)
          .updateAccount(accountId, updatedAccount)
          .then(
            (value) => Navigator.pop(context), // pop out of the loading dialog
          );

      Navigator.pop(context, updatedAccount.id); // pop out of the page
    }
  }

  // Will check and show error msg if a field is invalid.
  bool _checkFieldsInvalid(String newName, String newBalance) {
    // check NAME field
    isNameInvalid = CheckTextFieldsUtil.isStringInvalid(newName);

    isAmountInvalid = CheckTextFieldsUtil.isNumberStringInvalid(newBalance);

    notifyListeners();

    if (!isNameInvalid && !isAmountInvalid) {
      return false;
    }
    return true;
  }

  Future<void> delete(BuildContext context) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        AppLocalizations.of(context).translate('confirmDeleteAccountMsg'),
      ),
    );

    if (confirmed != null && confirmed && DbNotifier.accMap.length > 1) {
      final dbNotifier = Provider.of<DbNotifier>(context, listen: false);
      final settingsNotifier = Provider.of<SettingsNotifier>(context, listen: false);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadDialog();
        },
      );
      // 1. delete all transactions & recurring transactions related to the account
      await dbNotifier.deleteTransacsByAccount(accountId);
      await dbNotifier.deleteRecurringTransacsByAccount(accountId);

      // 2. delete the account
      await dbNotifier.deleteAccount(accountId);

      // 3. if the deleted account is the lastUsedAccountId, replace the lastUsedAccountId
      final lastUsedAccountId = settingsNotifier.getLastUsedAccountId();
      if (accountId == lastUsedAccountId) {
        final account = await DatabaseHelper.instance.queryFirstAccount();
        await settingsNotifier.setLastUsedAccountId(account.id);
      }

      await dbNotifier.initUserAccountsMap().then(
            (value) => Navigator.pop(context), // pop out of the loading dialog
          );

      Navigator.pop(context); // pop out of the edit page
      Navigator.pop(context); // pop out of the account page
    } else if (confirmed != null && confirmed && DbNotifier.accMap.length == 1) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context).translate('error')),
            content: Text(AppLocalizations.of(context).translate('mustHaveAtLeastOneAccount')),
            actions: <Widget>[
              FlatButton(
                child: Text(AppLocalizations.of(context).translate('closeCaps')),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
  }
}
