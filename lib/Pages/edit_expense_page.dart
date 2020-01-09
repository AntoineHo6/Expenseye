import 'package:expense_app/Components/Buttons/RaisedButtons/icon_btn.dart';
import 'package:expense_app/Components/AlertDialogs/confirmation_dialog.dart';
import 'package:expense_app/Components/TextFields/name_text_field.dart';
import 'package:expense_app/Components/TextFields/price_text_field.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Providers/edit_add_expense_model.dart';
import 'package:expense_app/Components/Buttons/RaisedButtons/date_picker_btn.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditExpensePage extends StatefulWidget {
  final Expense expense;

  EditExpensePage(this.expense);

  @override
  _EditExpense createState() => _EditExpense();
}

class _EditExpense extends State<EditExpensePage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new ChangeNotifierProvider(
      create: (_) =>
          new EditAddExpenseModel(widget.expense.date, widget.expense.category),
      child: Consumer<EditAddExpenseModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: MyColors.black00dp,
          appBar: AppBar(
            title: Text(widget.expense.name),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.white,
                onPressed: () => _delete(),
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
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
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
                      Theme(
                        data: ThemeData(
                          textTheme: Theme.of(context).textTheme,
                          hintColor: Colors.white,
                        ),
                        child: NameTextField(
                          controller: _nameController,
                          isNameInvalid: model.isNameInvalid,
                          onChanged: model.infoChanged,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
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
                      Theme(
                        data: ThemeData(
                          textTheme: Theme.of(context).textTheme,
                          hintColor: Colors.white,
                        ),
                        child: PriceTextField(
                          controller: _priceController,
                          isPriceInvalid: model.isPriceInvalid,
                          onChanged: model.infoChanged,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left: 3),
                        child: IconBtn(
                          model.category,
                          () => model.openIconsPage(context),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.only(right: 3),
                          child: DatePickerBtn(
                            model.date,
                            () => chooseDate(model),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  color: MyColors.black02dp,
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

  void chooseDate(EditAddExpenseModel localProvider) async {
    DateTime newDate =
        await DateTimeUtil.chooseDate(context, localProvider.date);

    localProvider.updateDate(newDate);
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

      Provider.of<ExpenseModel>(context, listen: false).editExpense(newExpense);

      Navigator.pop(context, 1);
    }
  }

  void _delete() async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => ConfirmationDialog(),
    );

    if (confirmed) {
      Provider.of<ExpenseModel>(context, listen: false)
          .deleteExpense(widget.expense.id);
      Navigator.pop(context, 2);
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
