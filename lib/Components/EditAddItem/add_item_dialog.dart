import 'package:Expenseye/Components/EditAddItem/icon_btn.dart';
import 'package:Expenseye/Components/EditAddItem/name_text_field.dart';
import 'package:Expenseye/Components/EditAddItem/price_text_field.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Providers/EditAddItem/add_item_model.dart';
import 'package:Expenseye/Components/EditAddItem/date_picker_btn.dart';
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
  final _priceController = TextEditingController();

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
              mainAxisSize: MainAxisSize.min,
              children: [
                NameTextField(
                  controller: _nameController,
                  isNameInvalid: model.isNameInvalid,
                ),
                PriceTextField(
                  controller: _priceController,
                  isPriceInvalid: model.isPriceInvalid,
                  hintText: AppLocalizations.of(context).translate('price'),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      IconBtn(
                        model.category,
                        () => model.openChooseCategoryPage(context),
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
              child: Text(AppLocalizations.of(context).translate('cancelCaps')),
              onPressed: () => Navigator.pop(context, false),
            ),
            FlatButton(
              textColor: Colors.white,
              child: Text(AppLocalizations.of(context).translate('submitCaps')),
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
