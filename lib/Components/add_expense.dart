import 'package:expense_app/Components/icon_btn.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Providers/edit_add_expense_model.dart';
import 'package:expense_app/Components/date_picker_btn.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
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
      create: (_) => new EditAddExpenseModel(DateTime.now()),
      child: Consumer<EditAddExpenseModel>(
        builder: (context, model, child) => AlertDialog(
          backgroundColor: MyColors.periwinkle,
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
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      IconBtn(),
                      SizedBox(
                        width: 15,
                      ),
                      DatePickerBtn(
                        model.date,
                        () => model.chooseDate(context, model.date),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              textColor: MyColors.indigoInk,
              child: new Text(Strings.cancelCaps),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              textColor: MyColors.indigoInk,
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

  void _save(EditAddExpenseModel localProvider) {
    final String newName = _nameController.text;
    final String newPrice = _priceController.text;
    final DateTime newDate = localProvider.date;

    bool areFieldsInvalid = localProvider.checkFieldsInvalid(
        name: newName, price: newPrice, date: newDate);

    // if all the fields are valid, add and quit
    if (!areFieldsInvalid) {
      Expense newExpense =
          new Expense(newName, double.parse(newPrice), newDate);

      Provider.of<ExpenseModel>(context).addExpense(newExpense);

      Navigator.pop(context);
    }
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
