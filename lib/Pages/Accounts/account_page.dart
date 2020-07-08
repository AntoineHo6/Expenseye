import 'package:Expenseye/Components/Transac/transac_list_tile.dart';
import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  final String accountId;

  AccountPage(this.accountId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DbModel.accMap[accountId].name),
      ),
      body: FutureBuilder<List<Transac>>(
        future: DatabaseHelper.instance.queryTransacsByAccount(accountId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TransacListTile(
                      snapshot.data[i],
                      onPressed: () => null,
                    ),
                  );
                },
              );
            } else {
              // code will never reach this point
              return Container();
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
