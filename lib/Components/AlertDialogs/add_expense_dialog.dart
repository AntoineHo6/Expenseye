import 'package:expense_app/Components/Buttons/RaisedButtons/icon_btn.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Providers/edit_add_expense_model.dart';
import 'package:expense_app/Components/Buttons/RaisedButtons/date_picker_btn.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseDialog extends StatefulWidget {
  final DateTime initialDate;

  AddExpenseDialog(this.initialDate);

  @override
  _AddExpense createState() => _AddExpense();
}

class _AddExpense extends State<AddExpenseDialog> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new ChangeNotifierProvider<EditAddExpenseModel>(
      create: (_) =>
          new EditAddExpenseModel(widget.initialDate, ExpenseCategory.food),
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
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 3),
                        child: IconBtn(model.category),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.only(right: 3),
                          child: SizedBox(
                            width: 125,
                            child: DatePickerBtn(
                              model.date,
                              () => chooseDate(model),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              textColor: MyColors.indigoInk,
              child: Text(Strings.cancelCaps),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              textColor: MyColors.indigoInk,
              child: Text(Strings.submitCaps),
              onPressed: () {
                _save(model);
              },
            ),
          ],
        ),
      ),
    );
  }

  void chooseDate(EditAddExpenseModel localProvider) async {
    DateTime newDate =
        await localProvider.chooseDate(context, widget.initialDate);

    localProvider.updateDate(newDate);
  }

  void _save(EditAddExpenseModel localProvider) {
    final String newName = _nameController.text;
    final String newPrice = _priceController.text;
    final DateTime newDate = localProvider.date;
    print(newDate.toIso8601String());

    bool areFieldsInvalid = localProvider.checkFieldsInvalid(
        name: newName, price: newPrice, date: newDate);

    // if all the fields are valid, add and quit
    if (!areFieldsInvalid) {
      Expense newExpense = new Expense(
          newName, double.parse(newPrice), newDate, localProvider.category);

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
