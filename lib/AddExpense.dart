import 'package:expense_app_beginner/Resources/Strings.dart';
import 'package:expense_app_beginner/TodayModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpense createState() => _AddExpense();
}

class _AddExpense extends State<AddExpense> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New Expense'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Name'),
        ),
        TextField(
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Price'),
        ),
      ]),
      actions: <Widget>[
        new FlatButton(
          child: new Text(Strings.cancelCaps),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: new Text(Strings.submitCaps),
          onPressed: () {
            Provider.of<TodayModel>(context, listen: false).addExpense();
            Navigator.of(context).pop();
          },
          
        ),
      ],
    );
  }
}

