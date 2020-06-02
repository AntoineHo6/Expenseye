import 'package:Expenseye/Components/EditAddItem/icon_btn.dart';
import 'package:Expenseye/Components/Global/name_text_field.dart';
import 'package:Expenseye/Components/Global/amount_text_field.dart';
import 'package:Expenseye/Components/EditAddItem/date_picker_btn.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/EditAddItem/edit_item_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EditItemPage extends StatefulWidget {
  final Item expense;

  EditItemPage(this.expense);

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

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
                // TODO: refactor redundant code
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
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
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          '${AppLocalizations.of(context).translate('amount')} :',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      AmountTextField(
                        controller: _amountController,
                        isAmountInvalid: model.isAmountInvalid,
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
                            _amountController.text,
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
    _amountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _nameController.text = widget.expense.name;
    _amountController.text = widget.expense.amount.toString();
    super.initState();
  }
}
