import 'package:Expenseye/Providers/Global/db_notifier.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class ChooseAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> accountKeys = new List();

    for (var key in DbNotifier.accMap.keys) {
      accountKeys.add(key);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('accounts')),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: ListView(
          children: accountKeys
              .map(
                (accountKey) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: RaisedButton(
                    onPressed: () => Navigator.pop(context, accountKey),
                    child: ListTile(
                      title: Text(DbNotifier.accMap[accountKey].name),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
