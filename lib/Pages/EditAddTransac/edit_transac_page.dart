import 'package:Expenseye/Components/EditAdd/category_picker_btn.dart';
import 'package:Expenseye/Components/EditAdd/date_picker_btn.dart';
import 'package:Expenseye/Components/EditAdd/delete_btn.dart';
import 'package:Expenseye/Components/Global/bottom_nav_button.dart';
import 'package:Expenseye/Components/EditAdd/name_text_field.dart';
import 'package:Expenseye/Components/EditAdd/amount_text_field.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Providers/EditAddTransac/edit_transac_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTransacPage extends StatefulWidget {
  final Transac transac;

  EditTransacPage(this.transac);

  @override
  _EditTransacPageState createState() => _EditTransacPageState();
}

class _EditTransacPageState extends State<EditTransacPage> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditTransacModel(widget.transac),
      child: Consumer<EditTransacModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(widget.transac.name),
            actions: <Widget>[
              DeleteBtn(
                onPressed: () async => await model.delete(context, widget.transac.id),
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: BottomNavButton(
              color: Theme.of(context).buttonColor,
              disabledColor: Theme.of(context).buttonColor.withOpacity(0.8),
              text: AppLocalizations.of(context).translate('saveCaps'),
              onPressed: model.didInfoChange
                  ? () async => await model.editTransac(
                        context,
                        widget.transac.id,
                        _nameController.text,
                        _amountController.text,
                      )
                  : null,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildTextField(
                  AppLocalizations.of(context).translate('name'),
                  NameTextField(
                    controller: _nameController,
                    isNameInvalid: model.isNameInvalid,
                    onChanged: model.infoChanged,
                  ),
                ),
                _buildTextField(
                  AppLocalizations.of(context).translate('amount'),
                  AmountTextField(
                    controller: _amountController,
                    isAmountInvalid: model.isAmountInvalid,
                    onChanged: model.infoChanged,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${AppLocalizations.of(context).translate('date')} :',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: DatePickerBtn(
                    width: double.infinity,
                    height: 80,
                    date: model.date,
                    iconSize: 32,
                    spaceBetweenSize: 15,
                    fontSize: 20,
                    onPressed: () async => await model.chooseDate(context, model.date),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${AppLocalizations.of(context).translate('category')} :',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: CategoryPickerBtn(
                    categoryId: model.categoryId,
                    onPressed: () async => await model.openChooseCategoryPage(context),
                    width: double.infinity,
                    height: 80,
                    iconSize: 160,
                    iconBottomPosition: -75,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String title, Widget textField) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: Text(
              '$title :',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          textField,
        ],
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
    _nameController.text = widget.transac.name;
    _amountController.text = widget.transac.amount.toString();
    super.initState();
  }
}
