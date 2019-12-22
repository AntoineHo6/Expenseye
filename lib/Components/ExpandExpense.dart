import 'package:expense_app_beginner/Blocs/ExpenseBloc.dart';
import 'package:expense_app_beginner/Expense.dart';
import 'package:expense_app_beginner/Resources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpandExpense extends StatefulWidget {
  final Expense expense;

  ExpandExpense(this.expense);

  @override
  _ExpandExpense createState() => _ExpandExpense();
}

class _ExpandExpense extends State<ExpandExpense> {
  // Price TextField
  final _priceController = TextEditingController();

  // Comment TextField
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _expenseBloc = Provider.of<ExpenseBloc>(context);

    _priceController.text = widget.expense.price.toString();
    _noteController.text = widget.expense.note;

    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.expense.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            //height: 30,
            child: TextField(
              controller: _priceController,
              maxLength: 10,
              decoration: InputDecoration(
                hintText: "Price",
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          TextField(
            maxLines: 10,
            maxLength: 500,
            controller: _noteController,
            decoration: InputDecoration(
              hintText: "Add a note",
              border: OutlineInputBorder(),
            ),
          ),
        Container(
          child: Row(
            children: <Widget>[
              
            ],
          ),
        ),
        ],
      ),
    );
  }

  @override
    void dispose() {
      _priceController.dispose();
      _noteController.dispose();
      super.dispose();
    }
}
