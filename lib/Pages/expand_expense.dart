import 'package:expense_app_beginner/ChangeNotifiers/expand_expense_model.dart';
import 'package:expense_app_beginner/ChangeNotifiers/Global/expense_model.dart';
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
              Container(
                color: Colors.yellowAccent, // * Temporary
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        Strings.name + ' :',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    TextField(
                      //textAlign: TextAlign.center,
                      maxLength: 50,
                      controller: _nameController,
                      onChanged: model.infoChanged,
                      decoration: InputDecoration(
                        hintText: Strings.name,
                        errorText: model.isNameInvalid
                            ? Strings.name + ' ' + Strings.isInvalid
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.amber, // * Temporary
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                //color: Colors.blueAccent,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        Strings.price + ' :',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    TextField(
                      maxLength: 10,
                      controller: _priceController,
                      onChanged: model.infoChanged,
                      decoration: InputDecoration(
                        hintText: Strings.price,
                        errorText: model.isPriceInvalid
                            ? Strings.price + ' ' + Strings.isInvalid
                            : null,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
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
