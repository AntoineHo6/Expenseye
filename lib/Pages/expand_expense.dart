import 'package:expense_app_beginner/ChangeNotifiers/expand_expense_model.dart';
import 'package:expense_app_beginner/ChangeNotifiers/Global/expense_model.dart';
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
    return new ChangeNotifierProvider<ExpandExpenseModel>(
      create: (_) => new ExpandExpenseModel(),
      child: Consumer<ExpandExpenseModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(widget.expense.title),
          ),
          body: Column(
            children: <Widget>[
              TextField(
                controller: _titleController,
                onChanged: model.infoChanged,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _priceController,
                maxLength: 10,
                onChanged: model.infoChanged,
                decoration: InputDecoration(
                  hintText: "Price",
                  //border: InputBorder.none,
                  errorText: model.isPriceInvalid
                      ? Strings.price + ' ' + Strings.cantBeEmpty
                      : null,
                ),
                keyboardType: TextInputType.number,
              ),
              RaisedButton(
                child: Text(Strings.saveCaps),
                onPressed: model.didInfoChange ? () => _save(model) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save(ExpandExpenseModel bloc) {
    bloc.checkFieldsInvalid(_priceController.text);

    if (!bloc.areFieldsInvalid) {
      Provider.of<ExpenseModel>(context).editExpense(widget.expense,
          price: double.parse(_priceController.text));
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
 * TODO:    final _expenseBloc = Provider.of<ExpenseModel>(context);
 * TODO: make a bloc for this class instead of redundant setState()
 */
