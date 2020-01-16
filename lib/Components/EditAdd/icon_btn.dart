import 'package:Expenseye/Utils/expense_category.dart';
import 'package:flutter/material.dart';

class IconBtn extends StatelessWidget {
  final ExpenseCategory category;
  final Function function;

  const IconBtn(this.category, this.function);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      onPressed: function,
      child: Icon(
        ExpenseCatProperties.properties[category]['iconData'],
        color: ExpenseCatProperties.properties[category]['color'],
      ),
    );
  }
}
