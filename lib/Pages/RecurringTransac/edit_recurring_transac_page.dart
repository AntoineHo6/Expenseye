import 'package:Expenseye/Components/EditAdd/RecurringTransac/periodicity_picker_btn.dart';
import 'package:Expenseye/Components/EditAdd/amount_text_field.dart';
import 'package:Expenseye/Components/EditAdd/category_picker_btn.dart';
import 'package:Expenseye/Components/EditAdd/date_picker_btn.dart';
import 'package:Expenseye/Components/EditAdd/delete_btn.dart';
import 'package:Expenseye/Components/EditAdd/name_text_field.dart';
import 'package:Expenseye/Components/Global/bottom_nav_button.dart';
import 'package:Expenseye/Models/recurring_transac.dart';
import 'package:Expenseye/Providers/RecurringTransac/edit_recurring_transac_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditRecurringTransacPage extends StatefulWidget {
  final RecurringTransac recurringTransac;

  EditRecurringTransacPage(this.recurringTransac);

  @override
  _EditRecurringTransacPageState createState() => _EditRecurringTransacPageState();
}

class _EditRecurringTransacPageState extends State<EditRecurringTransacPage> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditRecurringTransacModel(widget.recurringTransac),
      child: Consumer<EditRecurringTransacModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(widget.recurringTransac.name),
            actions: <Widget>[
              DeleteBtn(
                onPressed: () => model.delete(context),
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
                  ? () async => await model.editRecurringTransac(
                        context,
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
                  model,
                  AppLocalizations.of(context).translate('name'),
                  NameTextField(
                    controller: _nameController,
                    isNameInvalid: model.isNameInvalid,
                    onChanged: model.infoChanged,
                  ),
                ),
                _buildTextField(
                  model,
                  AppLocalizations.of(context).translate('amount'),
                  AmountTextField(
                    controller: _amountController,
                    isAmountInvalid: model.isAmountInvalid,
                    onChanged: model.infoChanged,
                  ),
                ),
                _btnTitle(
                  context,
                  AppLocalizations.of(context).translate('nextDueDate'),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: DatePickerBtn(
                    width: double.infinity,
                    height: 80,
                    date: model.recurringTransac.dueDate,
                    iconSize: 32,
                    spaceBetweenSize: 15,
                    fontSize: 20,
                    onPressed: () => model.chooseDate(context),
                  ),
                ),
                _btnTitle(
                  context,
                  AppLocalizations.of(context).translate('category'),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: CategoryPickerBtn(
                    categoryId: model.recurringTransac.category,
                    onPressed: () => model.openChooseCategoryPage(context),
                    width: double.infinity,
                    height: 80,
                    iconSize: 160,
                    iconBottomPosition: -75,
                  ),
                ),
                _btnTitle(
                  context,
                  AppLocalizations.of(context).translate('periodicity'),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: PeriodicityPickerBtn(
                    onPressed: () => model.openPeriodicityPickerPage(context),
                    width: double.infinity,
                    height: 80,
                    periodicity: model.recurringTransac.periodicity,
                    spaceBetweenSize: 15,
                    fontSize: 20,
                    iconSize: 32,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      EditRecurringTransacModel model, String title, Widget textField) {
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

  Widget _btnTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text('$title :', style: Theme.of(context).textTheme.headline6),
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
    _nameController.text = widget.recurringTransac.name;
    _amountController.text = widget.recurringTransac.amount.toString();
    super.initState();
  }
}