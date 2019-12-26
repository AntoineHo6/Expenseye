import 'package:expense_app_beginner/ChangeNotifiers/edit_add_expense_model.dart';
import 'package:expense_app_beginner/Components/date_picker_btn.dart';
import 'package:expense_app_beginner/Resources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpense createState() => _AddExpense();
}

class _AddExpense extends State<AddExpense> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new ChangeNotifierProvider<EditAddExpenseModel>(
      create: (_) => new EditAddExpenseModel(),
      child: Consumer<EditAddExpenseModel>(
        builder: (context, model, child) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(Strings.newExpense),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  maxLength: 50,
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: Strings.name,
                    errorText: model.isNameInvalid
                        ? Strings.name + ' ' + Strings.isInvalid
                        : null,
                  ),
                ),
                TextField(
                  maxLength: 10,
                  controller: _priceController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: Strings.price,
                    errorText: model.isPriceInvalid
                        ? Strings.price + ' ' + Strings.isInvalid
                        : null,
                  ),
                  keyboardType: TextInputType.number,
                ),
                DatePickerBtn(model),
              ],
            ),
          ),
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
                _save(model);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _save(EditAddExpenseModel localNotifier) {
    final String newName = _nameController.text;
    final String newPrice = _priceController.text;
    final DateTime newDate = localNotifier.date;

    localNotifier.saveAddedExpense(context,
        name: newName, price: newPrice, date: newDate);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}

/**
 * TODO: add date and time for expense
 */
