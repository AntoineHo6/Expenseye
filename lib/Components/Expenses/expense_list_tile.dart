import 'package:Expenseye/Models/Expense.dart';
import 'package:Expenseye/Utils/expense_category.dart';
import 'package:flutter/material.dart';

class ExpenseListTile extends StatelessWidget {
  final Expense expense;
  final Function onTap;

  ExpenseListTile(this.expense, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(ExpenseCatProperties.properties[expense.category]['iconData'],
          color: ExpenseCatProperties.properties[expense.category]['color']),
      title: Text(
        expense.name,
      ),
      trailing: Text(
        '${expense.price.toStringAsFixed(2)} \$',
      ),
      onTap: onTap,
    );
  }
}
