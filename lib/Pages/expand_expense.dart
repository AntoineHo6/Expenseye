import 'package:expense_app_beginner/Blocs/expand_expense_bloc.dart';
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
  //bool _isTitleInvalid = false;

  final _priceController = TextEditingController();
  //bool _isPriceInvalid = false;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ExpandExpenseBloc>(context);

    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.expense.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _titleController,
            onChanged: bloc.infoChanged,
            decoration: InputDecoration(
              hintText: "Title",
              border: InputBorder.none,
            ),
          ),
          TextField(
            controller: _priceController,
            maxLength: 10,
            onChanged: bloc.infoChanged,
            decoration: InputDecoration(
              hintText: "Price",
              //border: InputBorder.none,
              errorText: bloc.isPriceInvalid
                  ? Strings.price + ' ' + Strings.cantBeEmpty
                  : null,
            ),
            keyboardType: TextInputType.number,
          ),
          RaisedButton(
            child: Text(Strings.saveCaps),
            onPressed: bloc.didInfoChange ? _save : null,
          ),
        ],
      ),
    );
  }

  void _save() {
    final expandExpenseBloc = Provider.of<ExpandExpenseBloc>(context);
    
    expandExpenseBloc.checkFieldsInvalid(_priceController.text);

    if (!expandExpenseBloc.areFieldsInvalid) {
      Provider.of<ExpenseBloc>(context)
        .editExpense(widget.expense, price: double.parse(_priceController.text));
    }

    Navigator.pop(context); 
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
