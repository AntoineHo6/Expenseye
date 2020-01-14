import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:flutter/material.dart';

class ExpenseListTile extends StatelessWidget {
  final Expense expense;
  final Function onTap;

  ExpenseListTile(this.expense, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(CategoryProperties.properties[expense.category]['iconData'],
          color: CategoryProperties.properties[expense.category]['color']),
      title: Text(
        expense.name,
      ),
      trailing: Text(
        '${expense.price.toString()} \$',
      ),
      onTap: onTap,
    );
  }
}
