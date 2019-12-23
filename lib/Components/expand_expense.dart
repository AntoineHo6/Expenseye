import 'package:expense_app_beginner/Blocs/expense_bloc.dart';
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
  bool _isPriceInvalid = false;

  bool didInfoChange = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.expense.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _titleController,
            onChanged: _infoChanged,
            decoration: InputDecoration(
              hintText: "Title",
              border: InputBorder.none,
            ),
          ),
          TextField(
            controller: _priceController,
            maxLength: 10,
            onChanged: _infoChanged,
            decoration: InputDecoration(
              hintText: "Price",
              //border: InputBorder.none,
              errorText: _isPriceInvalid
                ? Strings.price + ' ' + Strings.cantBeEmpty
                : null,
            ),
            keyboardType: TextInputType.number,
          ),
          RaisedButton(
            child: Text(Strings.saveCaps),
            onPressed: didInfoChange ? _save : null,
          )
        ],
      ),
    );
  }

  void _infoChanged(String text){
    setState(() {
      didInfoChange = true;
    });
  }

  void _save() {
    String newTitle = _titleController.text;

    double newPrice;
    try {
      _isPriceInvalid = false;
      newPrice = double.parse(_priceController.text);
    }
    on FormatException {
      setState(() {
        _isPriceInvalid = true;
      });
    }

    Provider.of<ExpenseBloc>(context)
        .editExpense(widget.expense, title: newTitle, price: newPrice);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _titleController.text = widget.expense.title;
    _priceController.text = widget.expense.price.toString();
    super.initState();
  }
}

/**
 * TODO: update expense information on dispose() with:
 * TODO:    final _expenseBloc = Provider.of<ExpenseBloc>(context);
 * TODO: make a bloc for this class instead of redundant setState()
 */
