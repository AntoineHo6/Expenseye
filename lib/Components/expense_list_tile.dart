import 'package:expense_app/Utils/date_time_util.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:flutter/material.dart';

class ExpenseListTile extends StatelessWidget {
  final expense;
  final onTap;

  ExpenseListTile({this.expense, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(CategoryProperties.properties[expense.category]['iconData'],
          color: CategoryProperties.properties[expense.category]['color']),
      title: Text(
        expense.name,
        style: Theme.of(context).textTheme.subhead,
      ),
      // subtitle: Text(
      //   expense.price.toString(),
      //   style: Theme.of(context).textTheme.subtitle,
      // ),
      // trailing: Text(
      //   '${expense.price.toString()} \$',
      //   style: Theme.of(context).textTheme.subtitle,
      // ),
      trailing: Text(
        //DateTimeUtil.formattedDate(expense.date),
        expense.date.toIso8601String(),
        style: Theme.of(context).textTheme.subtitle,
      ),
      onTap: onTap,
    );
  }
}
