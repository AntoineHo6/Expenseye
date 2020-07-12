import 'package:Expenseye/Components/Global/app_bar_btn.dart';
import 'package:Expenseye/Components/Global/future_total_box.dart';
import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Models/account.dart';
import 'package:Expenseye/Pages/Accounts/account_page.dart';
import 'package:Expenseye/Pages/Accounts/add_account_page.dart';
import 'package:Expenseye/Providers/Global/db_notifier.dart';
import 'package:Expenseye/Resources/Themes/app_colors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('accounts')),
        actions: <Widget>[
          AppBarBtn(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddAccountPage(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder<List<Account>>(
        future: Provider.of<DbNotifier>(context).queryAccounts(),
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Row(
                    children: <Widget>[
                      FutureTotalBox(
                        title: AppLocalizations.of(context).translate('assets'),
                        future: DatabaseHelper.instance.queryIncomesTotal(),
                        textColor: ColorChooserFromTheme.incomeColor,
                      ),
                      FutureTotalBox(
                        title: AppLocalizations.of(context).translate('liabilities'),
                        future: DatabaseHelper.instance.queryExpensesTotal(),
                        textColor: ColorChooserFromTheme.expenseColor,
                      ),
                      FutureTotalBox(
                        title: AppLocalizations.of(context).translate('total'),
                        future: DatabaseHelper.instance.queryTransacsTotal(),
                        textColor: ColorChooserFromTheme.balanceColor,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: snapshot.data.map(
                      (account) {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: RaisedButton(
                            onPressed: () => _openAccountPage(context, account.id),
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
                                  color: ColorChooserFromTheme.balanceColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            );
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

  Future<void> _openAccountPage(BuildContext context, String accountId) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccountPage(accountId)),
    );
  }
}
