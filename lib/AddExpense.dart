import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpense createState() => _AddExpense();
}

class _AddExpense extends State<AddExpense> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('New Expense'),
        content: TextField(
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Enter a search term'),
        ));
  }
}
