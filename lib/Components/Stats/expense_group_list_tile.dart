import 'package:expense_app/Utils/chart_util.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:flutter/material.dart';

class ExpenseGroupListTile extends StatelessWidget {
  final ExpenseGroup expenseGroup;
  final double totalCost;

  ExpenseGroupListTile(
      {@required this.expenseGroup, @required this.totalCost});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        CategoryProperties.properties[expenseGroup.category]['iconData'],
        color: CategoryProperties.properties[expenseGroup.category]['color'],
      ),
      title:
          Text(CategoryProperties.properties[expenseGroup.category]['string']),
      subtitle: Text('${_calcPercentage()}\%'),
      trailing: Text('${expenseGroup.total.toString()} \$'),
    );
  }

  int _calcPercentage() {
    int percentage;

    // avoid using .round() on infinity caused by totalCost being zero.
    try {
      percentage = (expenseGroup.total * 100 / totalCost).round();
    }
    catch(e) {
      percentage = -1;
    }

    return percentage;
  }
}
