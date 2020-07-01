import 'package:Expenseye/Components/Global/app_bar_add_btn.dart';
import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Models/account.dart';
import 'package:Expenseye/Pages/Accounts/add_account_page.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class AccountsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        future: DatabaseHelper.instance.queryAccounts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              return Column(
                children: snapshot.data.map((e) {
                  return Text(e.name);
                }).toList(),
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
}
