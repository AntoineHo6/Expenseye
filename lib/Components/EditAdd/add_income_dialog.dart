import 'package:Expenseye/Components/EditAdd/icon_btn.dart';
import 'package:Expenseye/Components/EditAdd/name_text_field.dart';
import 'package:Expenseye/Components/EditAdd/price_text_field.dart';
import 'package:Expenseye/Providers/EditAdd/add_item_model.dart';
import 'package:Expenseye/Components/EditAdd/date_picker_btn.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddIncomeDialog extends StatefulWidget {
  final DateTime initialDate;

  AddIncomeDialog(this.initialDate);

  @override
  _AddIncomeDialogState createState() => _AddIncomeDialogState();
}

class _AddIncomeDialogState extends State<AddIncomeDialog> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new ChangeNotifierProvider(
      create: (_) => new AddItemModel(widget.initialDate, 1),
      child: Consumer<AddItemModel>(
        builder: (context, model, child) => AlertDialog(
          title: Row(
            children: <Widget>[
              Icon(Icons.account_balance_wallet, color: Colors.white),
              const SizedBox(width: 10),
              const Text('New income'),
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
                  hintText: Strings.amount,
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
              onPressed: () => model.addItem(
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
