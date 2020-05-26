import 'package:Expenseye/Components/EditAdd/icon_btn.dart';
import 'package:Expenseye/Components/EditAdd/name_text_field.dart';
import 'package:Expenseye/Components/EditAdd/price_text_field.dart';
import 'package:Expenseye/Components/EditAdd/date_picker_btn.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/EditAdd/edit_item_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditExpensePage extends StatefulWidget {
  final Item expense;

  EditExpensePage(this.expense);

  @override
  _EditExpense createState() => _EditExpense();
}

class _EditExpense extends State<EditExpensePage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditItemModel(
          widget.expense.date, widget.expense.category, widget.expense.type),
      child: Consumer<EditItemModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(widget.expense.name),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.white,
                onPressed: () => model.delete(context, widget.expense.id),
                child: const Icon(Icons.delete_forever),
                shape: const CircleBorder(
                  side: const BorderSide(color: Colors.transparent),
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
                          '${AppLocalizations.of(context).translate('name')} :',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      NameTextField(
                        controller: _nameController,
                        isNameInvalid: model.isNameInvalid,
                        onChanged: model.infoChanged,
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
                          '${AppLocalizations.of(context).translate('price')} :',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      PriceTextField(
                        controller: _priceController,
                        isPriceInvalid: model.isPriceInvalid,
                        hintText:
                            AppLocalizations.of(context).translate('value'),
                        onChanged: model.infoChanged,
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
                      IconBtn(
                        model.category,
                        () => model.openChooseCategoryPage(context),
                      ),
                      DatePickerBtn(
                        model.date,
                        function: () => model.chooseDate(context, model.date),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  textTheme: ButtonTextTheme.primary,
                  child: Text(
                    AppLocalizations.of(context).translate('saveCaps'),
                  ),
                  onPressed: model.didInfoChange
                      ? () => model.editItem(
                            context,
                            widget.expense.id,
                            _nameController.text,
                            _priceController.text,
                          )
                      : null,
                ),
              ],
            ),
          ),
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

  @override
  void initState() {
    _nameController.text = widget.expense.name;
    _priceController.text = widget.expense.value.toString();
    super.initState();
  }
}
