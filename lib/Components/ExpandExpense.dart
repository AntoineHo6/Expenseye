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
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleController.text = widget.expense.title;
    _priceController.text = widget.expense.price.toString();
    _noteController.text = widget.expense.note;

    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.expense.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: "Title",
              border: InputBorder.none,
            ),
          ),
          TextField(
            controller: _priceController,
            maxLength: 10,
            decoration: InputDecoration(
              hintText: "Price",
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.number,
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: TextField(
              maxLines: 5,
              maxLength: 200,
              controller: _noteController,
              decoration: InputDecoration(
                hintText: "Add a note",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    //final _expenseBloc = Provider.of<ExpenseBloc>(context); MAKE A FUNC to refer to this
    _priceController.dispose();
    _noteController.dispose();
    print('Going back to todayPage');
    super.dispose();
  }
}
