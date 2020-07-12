import 'package:Expenseye/Components/Global/app_bar_btn.dart';
import 'package:Expenseye/Components/Transac/transacs_day_box.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Pages/Accounts/edit_account_page.dart';
import 'package:Expenseye/Providers/Global/db_notifier.dart';
import 'package:Expenseye/Utils/transac_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        title: Text(DbNotifier.accMap[myAccountId].name),
        actions: <Widget>[
          AppBarBtn(
            onPressed: () async => await _openEditAccountPage(context, myAccountId),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: FutureBuilder<List<Transac>>(
        future: Provider.of<DbNotifier>(context).queryTransacsByAccount(myAccountId),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var transacsSplitByDay = TransacUtil.splitTransacsByDay(snapshot.data);

            return ListView.builder(
              itemCount: transacsSplitByDay.length,
              itemBuilder: (context, i) {
                return TransacsDayBox(transacsSplitByDay[i]);
              },
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

  @override
  void initState() {
    myAccountId = widget.accountId;
    super.initState();
  }
}
