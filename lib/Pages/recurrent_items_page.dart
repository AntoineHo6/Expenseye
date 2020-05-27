import 'package:Expenseye/Enums/recurrent_item_type.dart';
import 'package:Expenseye/Models/recurrent_item.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecurrentItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _dbModel = Provider.of<DbModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('recurrentItems')),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.white30,
            child: ListTile(
              leading: Icon(Icons.fastfood, color: Colors.white),
              title: Text('Burger'),
              subtitle: Text('weekly\nNext payment: May 31st, 2020'),
              trailing: Text('20 \$'),
              isThreeLine: true,
            ),
          ),
        ],
      ),
    );
  }
}
