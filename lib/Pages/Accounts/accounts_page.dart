import 'package:Expenseye/Components/Global/app_bar_add_btn.dart';
import 'package:Expenseye/Components/Global/confirmation_dialog.dart';
import 'package:Expenseye/Components/Global/load_dialog.dart';
import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Models/account.dart';
import 'package:Expenseye/Pages/Accounts/add_account_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/settings_notifier.dart';
import 'package:Expenseye/Resources/Themes/app_colors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _dbModel = Provider.of<DbModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('accounts')),
        actions: <Widget>[
          AppBarAddBtn(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddAccountPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Account>>(
        future: _dbModel.queryAccounts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              return Column(
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  Expanded(
                    child: ListView(
                      children: snapshot.data.map((account) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          child: RaisedButton(
                            onPressed: () => temporaryDeleteFunction(context, account.id),
                            child: ListTile(
                              title: Row(
                                children: <Widget>[
                                  const Icon(Icons.account_balance_wallet),
                                  const SizedBox(width: 8),
                                  Text(account.name),
                                ],
                              ),
                              trailing: Text(
                                account.balance.toString(),
                                style: TextStyle(
                                  color: ColorChooserFromTheme.balanceColorChooser(
                                    Provider.of<SettingsNotifier>(context).getTheme(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            } else {
              return Align(
                alignment: Alignment.center,
                child: Text(
                  'TODO: replace with no accounts error', // TODO
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            }
          } else {
            return const Align(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> temporaryDeleteFunction(BuildContext context, String accountId) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(
        AppLocalizations.of(context).translate('confirmDeleteMsg'), //TODO: change msg
      ),
    );

    if (confirmed != null && confirmed && DbModel.accMap.length > 1) {
      // TODO: and not the last account
      final dbNotifier = Provider.of<DbModel>(context, listen: false);
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
            (value) => Navigator.pop(context),
          );
    } else if (confirmed != null && confirmed && DbModel.accMap.length == 1) {
      print('NEED AT LEAST 1 ACCOUNT');
      // TODO: replace with dialog
    }
  }
}
