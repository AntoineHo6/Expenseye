import 'package:expense_app_beginner/ChangeNotifiers/edit_add_expense_model.dart';
import 'package:expense_app_beginner/Components/date_picker_btn.dart';
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
    return new ChangeNotifierProvider<EditAddExpenseModel>(
      create: (_) => new EditAddExpenseModel(),
      child: Consumer<EditAddExpenseModel>(
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
              Container(
                margin: EdgeInsets.all(40),
                child: DatePickerBtn(model),
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

  void _save(EditAddExpenseModel localNotifier) {
    final String newName = _nameController.text;
    final String newPrice = _priceController.text;

    localNotifier.saveEditedExpense(context, widget.expense,
        name: newName, price: newPrice);
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
