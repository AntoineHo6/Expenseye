import 'package:expense_app/Components/Buttons/RaisedButtons/icon_btn.dart';
import 'package:expense_app/Components/confirmation_dialog.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Providers/edit_add_expense_model.dart';
import 'package:expense_app/Components/Buttons/RaisedButtons/date_picker_btn.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditExpense extends StatefulWidget {
  final Expense expense;

  EditExpense(this.expense);

  @override
  _EditExpense createState() => _EditExpense();
}

class _EditExpense extends State<EditExpense> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);

    return new ChangeNotifierProvider<EditAddExpenseModel>(
      create: (_) =>
          new EditAddExpenseModel(widget.expense.date, widget.expense.category),
      child: Consumer<EditAddExpenseModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: MyColors.periwinkle,
          appBar: AppBar(
            title: Text(widget.expense.name),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.white,
                onPressed: () => _delete(_expenseModel),
                child: Icon(Icons.delete_forever),
                shape: CircleBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
              ),
            ],
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 3),
                        child: IconBtn(model.category),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 3),
                          child: DatePickerBtn(model.date),
                        ),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  color: MyColors.blueberry,
                  textTheme: ButtonTextTheme.primary,
                  child: Text(
                    Strings.saveCaps,
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

  void _save(EditAddExpenseModel localProvider) {
    final String newName = _nameController.text;
    final String newPrice = _priceController.text;

    bool areFieldsInvalid =
        localProvider.checkFieldsInvalid(name: newName, price: newPrice);

    // if all the fields are valid, update and quit
    if (!areFieldsInvalid) {
      Expense newExpense = new Expense.withId(widget.expense.id, newName,
          double.parse(newPrice), localProvider.date, localProvider.category);

      Provider.of<ExpenseModel>(context).editExpense(newExpense);

      Navigator.pop(context);
    }
  }

  void _delete(ExpenseModel globalProvider) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(widget.expense.id),
    );

    if (confirmed) {
      globalProvider.deleteExpense(widget.expense.id);
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
