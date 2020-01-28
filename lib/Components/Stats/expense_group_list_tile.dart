import 'package:Expenseye/Utils/chart_util.dart';
import 'package:Expenseye/Utils/item_category.dart';
import 'package:flutter/material.dart';

class ExpenseGroupListTile extends StatelessWidget {
  final ExpenseGroup expenseGroup;
  final double totalCost;

  ExpenseGroupListTile({@required this.expenseGroup, @required this.totalCost});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        ItemCategories.properties[expenseGroup.category]['iconData'],
        color: ItemCategories.properties[expenseGroup.category]['color'],
      ),
      title: Text(
          ItemCategories.properties[expenseGroup.category]['string']),
      subtitle: Text('${_calcPercentage()}\%'),
      trailing: Text('${expenseGroup.total.toStringAsFixed(2)} \$'),
    );
  }

  int _calcPercentage() {
    int percentage;

    // avoids using .round() on infinity caused by totalCost being zero.
    try {
      percentage = (expenseGroup.total * 100 / totalCost).round();
    } catch (e) {
      percentage = -1;
    }

    return percentage;
  }
}
