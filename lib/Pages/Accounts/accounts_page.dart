import 'package:Expenseye/Components/Global/app_bar_add_btn.dart';
import 'package:Expenseye/Models/account.dart';
import 'package:Expenseye/Pages/Accounts/add_account_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
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
                children: snapshot.data.map((account) {
                  return ListTile(
                    title: Text(account.name),
                    trailing: Text(account.balance.toString()),
                  );
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
