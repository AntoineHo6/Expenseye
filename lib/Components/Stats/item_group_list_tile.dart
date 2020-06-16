import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Utils/chart_util.dart';
import 'package:flutter/material.dart';

class ItemGroupListTile extends StatelessWidget {
  final CategoryGroup expenseGroup;
  final double totalCost;

  ItemGroupListTile({@required this.expenseGroup, @required this.totalCost});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        DbModel.catMap[expenseGroup.category].iconData,
        color: DbModel.catMap[expenseGroup.category].color,
      ),
      title: Text(
        DbModel.catMap[expenseGroup.category].name,
      ),
      subtitle: Text('${_calcPercentage()}\%'),
      trailing: Text(
        '${expenseGroup.total.toStringAsFixed(2)} \$',
      ),
    );
  }

  String _calcPercentage() {
    String percentage;

    try {
      percentage = (expenseGroup.total * 100 / totalCost).toStringAsFixed(1);
    } catch (e) {
      percentage = '-1';
    }

    return percentage;
  }
}
