import 'package:Expenseye/Components/Global/app_bar_btn.dart';
import 'package:Expenseye/Components/Transac/transac_list_tile.dart';
import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Pages/Accounts/edit_account_page.dart';
import 'package:Expenseye/Pages/EditAddTransac/edit_transac_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  final String accountId;

  AccountPage(this.accountId);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String myAccountId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DbModel.accMap[myAccountId].name),
        actions: <Widget>[
          AppBarBtn(
            onPressed: () async => await _openEditAccountPage(context, myAccountId),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: FutureBuilder<List<Transac>>(
        future: DatabaseHelper.instance.queryTransacsByAccount(myAccountId),
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
                      onPressed: () async => await _openEditTransacPage(context, snapshot.data[i]),
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

  Future<void> _openEditAccountPage(BuildContext context, String accountId) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAccountPage(accountId),
      ),
    ).then((newAccountId) {
      if (newAccountId != null) {
        setState(() {
          myAccountId = newAccountId;
        });
      }
    });
  }

  Future<void> _openEditTransacPage(BuildContext context, Transac transac) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTransacPage(transac),
      ),
    ).then((_) => setState(() {}));
  }

  @override
  void initState() {
    myAccountId = widget.accountId;
    super.initState();
  }
}
