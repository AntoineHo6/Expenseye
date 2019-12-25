import 'package:expense_app_beginner/ChangeNotifiers/expand_expense_model.dart';
import 'package:expense_app_beginner/ChangeNotifiers/Global/expense_model.dart';
import 'package:expense_app_beginner/Components/name_field_container.dart';
import 'package:expense_app_beginner/Components/price_field_container.dart';
import 'package:expense_app_beginner/Models/Expense.dart';
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
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new ChangeNotifierProvider<ExpandExpenseModel>(
      create: (_) => new ExpandExpenseModel(),
      child: Consumer<ExpandExpenseModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(widget.expense.name),
          ),
          body: Column(
            children: <Widget>[
              NameFieldContainer(
                  _nameController, model.isNameInvalid, model.infoChanged),
              PriceFieldContainer(
                  _priceController, model.isPriceInvalid, model.infoChanged),
              RaisedButton(
                child: Text(
                  Strings.saveCaps,
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: model.didInfoChange ? () => _save(model) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save(ExpandExpenseModel localNotifier) {
    // 1. will check and show error msg if a field is invalid
    final String newName = _nameController.text;
    final String newPrice = _priceController.text;
    localNotifier.checkFieldsInvalid(name: newName, price: newPrice);

    // 2. if all the fields are valid, update and quit
    if (!localNotifier.areFieldsInvalid) {
      Provider.of<ExpenseModel>(context)
          .editExpense(widget.expense, name: newName, price: newPrice);

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _nameController.text = widget.expense.name;
    _priceController.text = widget.expense.price.toString();
    super.initState();
  }
}
