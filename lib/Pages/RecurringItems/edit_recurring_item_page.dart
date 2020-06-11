import 'package:Expenseye/Components/EditAdd/RecurringItem/periodicity_picker_btn.dart';
import 'package:Expenseye/Components/EditAdd/amount_text_field.dart';
import 'package:Expenseye/Components/EditAdd/category_picker_btn.dart';
import 'package:Expenseye/Components/EditAdd/date_picker_btn.dart';
import 'package:Expenseye/Components/EditAdd/delete_btn.dart';
import 'package:Expenseye/Components/EditAdd/name_text_field.dart';
import 'package:Expenseye/Components/Global/bottom_nav_button.dart';
import 'package:Expenseye/Models/recurring_item.dart';
import 'package:Expenseye/Providers/RecurringItems/edit_recurring_item_model.dart';
import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditRecurringItemPage extends StatefulWidget {
  final RecurringItem recurringItem;

  EditRecurringItemPage(this.recurringItem);

  @override
  _EditRecurringItemPageState createState() => _EditRecurringItemPageState();
}

class _EditRecurringItemPageState extends State<EditRecurringItemPage> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditRecurringItemModel(widget.recurringItem),
      child: Consumer<EditRecurringItemModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(widget.recurringItem.name),
            actions: <Widget>[
              DeleteBtn(
                onPressed: () => model.delete(context),
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: BottomNavButton(
              color: MyColors.secondaryDarker,
              disabledColor: MyColors.secondaryDisabled,
              text: AppLocalizations.of(context).translate('saveCaps'),
              onPressed: model.didInfoChange
                  ? () async => await model.editRecurringItem(
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
                // TODO: refactor redundant code
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 30),
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
                _btnTitle(
                  context,
                  AppLocalizations.of(context).translate('nextDueDate'),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: DatePickerBtn(
                    minWidth: double.infinity,
                    height: 80,
                    date: model.recurringItem.dueDate,
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
                    categoryId: model.recurringItem.category,
                    onPressed: () => model.openChooseCategoryPage(context),
                    minWidth: double.infinity,
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
                    minWidth: double.infinity,
                    height: 80,
                    periodicity: model.recurringItem.periodicity,
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
    _nameController.text = widget.recurringItem.name;
    _amountController.text = widget.recurringItem.amount.toString();
    super.initState();
  }
}
