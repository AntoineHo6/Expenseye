import 'package:expense_app_beginner/Providers/edit_add_expense_model.dart';
import 'package:expense_app_beginner/Components/date_picker_btn.dart';
import 'package:expense_app_beginner/Models/Expense.dart';
import 'package:expense_app_beginner/Resources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditExpense extends StatefulWidget {
  final Expense expense;

  EditExpense(this.expense);

  @override
  _ExpandExpense createState() => _ExpandExpense();
}

class _ExpandExpense extends State<EditExpense> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new ChangeNotifierProvider<EditAddExpenseModel>(
      create: (_) => new EditAddExpenseModel(widget.expense.date),
      child: Consumer<EditAddExpenseModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(widget.expense.name),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
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
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 20),
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
                Container(
                  margin: EdgeInsets.all(40),
                  child: DatePickerBtn(
                    model.date,
                    () => model.chooseDate(context, model.date),
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
      ),
    );
  }

  void _save(EditAddExpenseModel localNotifier) {
    final String newName = _nameController.text;
    final String newPrice = _priceController.text;

    localNotifier.saveEditedExpense(context, widget.expense,
        name: newName, price: newPrice, date: localNotifier.date);
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
