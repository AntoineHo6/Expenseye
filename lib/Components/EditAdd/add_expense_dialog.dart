import 'package:Expenseye/Components/EditAdd/icon_btn.dart';
import 'package:Expenseye/Components/EditAdd/name_text_field.dart';
import 'package:Expenseye/Components/EditAdd/price_text_field.dart';
import 'package:Expenseye/Providers/EditAdd/add_expense_model.dart';
import 'package:Expenseye/Components/EditAdd/date_picker_btn.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseDialog extends StatefulWidget {
  final DateTime initialDate;

  AddExpenseDialog(this.initialDate);

  @override
  _AddExpenseDialogState createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new ChangeNotifierProvider(
      create: (_) => new AddExpenseModel(widget.initialDate),
      child: Consumer<AddExpenseModel>(
        builder: (context, model, child) => AlertDialog(
          title: Row(
            children: <Widget>[
              Icon(Icons.attach_money, color: Colors.white),
              const Text(Strings.newExpense),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                NameTextField(
                  controller: _nameController,
                  isNameInvalid: model.isNameInvalid,
                ),
                PriceTextField(
                  controller: _priceController,
                  isPriceInvalid: model.isPriceInvalid,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      IconBtn(
                        model.category,
                        () => model.openCategoriesPage(context),
                      ),
                      DatePickerBtn(
                        model.date,
                        function: () =>
                            model.chooseDate(context, widget.initialDate),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              child: Text(Strings.cancelCaps),
              onPressed: () => Navigator.pop(context, false),
            ),
            FlatButton(
              textColor: Colors.white,
              child: Text(Strings.submitCaps),
              onPressed: () => model.addExpense(
                  context, _nameController.text, _priceController.text),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
