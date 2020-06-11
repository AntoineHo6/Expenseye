import 'package:Expenseye/Components/EditAdd/category_picker_btn.dart';
import 'package:Expenseye/Components/EditAdd/date_picker_btn.dart';
import 'package:Expenseye/Components/EditAdd/name_text_field.dart';
import 'package:Expenseye/Components/EditAdd/amount_text_field.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Providers/EditAddItem/add_item_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddItemDialog extends StatefulWidget {
  final DateTime initialDate;
  final ItemType type;

  AddItemDialog(this.initialDate, this.type);

  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String title;
    Icon icon;
    if (widget.type == ItemType.expense) {
      title = AppLocalizations.of(context).translate('newExpense');
      icon = Icon(Icons.attach_money, color: Colors.white);
    } else {
      title = AppLocalizations.of(context).translate('newIncome');
      icon = Icon(Icons.account_balance_wallet, color: Colors.white);
    }

    return new ChangeNotifierProvider(
      create: (_) => new AddItemModel(widget.initialDate, widget.type),
      child: Consumer<AddItemModel>(
        builder: (context, model, child) => AlertDialog(
          title: Row(
            children: <Widget>[
              icon,
              const SizedBox(width: 10),
              Text(title),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                NameTextField(
                  controller: _nameController,
                  isNameInvalid: model.isNameInvalid,
                ),
                AmountTextField(
                  controller: _amountController,
                  isAmountInvalid: model.isAmountInvalid,
                ),
                const SizedBox(
                  height: 20,
                ),
                DatePickerBtn(
                  minWidth: double.infinity,
                  height: 40,
                  date: model.date,
                  onPressed: () => model.chooseDate(
                    context,
                    widget.initialDate,
                  ),
                ),
                CategoryPickerBtn(
                  minWidth: double.infinity,
                  height: 40,
                  iconSize: 30,
                  iconBottomPosition: null,
                  categoryId: model.category,
                  onPressed: () => model.openChooseCategoryPage(context),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              child: Text(AppLocalizations.of(context).translate('cancelCaps')),
              onPressed: () => Navigator.pop(context, false),
            ),
            FlatButton(
              textColor: Colors.white,
              child: Text(AppLocalizations.of(context).translate('submitCaps')),
              onPressed: () => model.addItem(
                context,
                _nameController.text.trim(),
                _amountController.text.trim(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}