import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Models/account.dart';
import 'package:flutter/material.dart';

class AccountsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
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
                  'TODO: replace',
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
