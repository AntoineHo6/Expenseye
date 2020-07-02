import 'package:Expenseye/Components/Global/app_bar_add_btn.dart';
import 'package:Expenseye/Components/Global/confirmation_dialog.dart';
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
        AppLocalizations.of(context).translate('confirmDeleteMsg'),
      ),
    );

    if (confirmed != null && confirmed) {
      // TODO: delete all transactions related to the account
      // TODO: check if the deleted account is the lastUsedAccountId
      Provider.of<DbModel>(context).deleteAccount(accountId);
    }
  }
}
