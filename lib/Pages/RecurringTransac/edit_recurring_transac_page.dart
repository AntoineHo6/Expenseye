import 'package:Expenseye/Components/EditAdd/RecurringTransac/periodicity_picker_btn.dart';
import 'package:Expenseye/Components/EditAdd/amount_text_field.dart';
import 'package:Expenseye/Components/EditAdd/category_picker_btn.dart';
import 'package:Expenseye/Components/EditAdd/date_picker_btn.dart';
import 'package:Expenseye/Components/EditAdd/name_text_field.dart';
import 'package:Expenseye/Components/Global/app_bar_btn.dart';
import 'package:Expenseye/Components/Global/bottom_nav_button.dart';
import 'package:Expenseye/Components/Global/subheader.dart';
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
              AppBarBtn(
                onPressed: () => model.delete(context),
                icon: const Icon(Icons.delete_forever),
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
                const SizedBox(
                  height: 10,
                ),
                SubHeader(
                  title: AppLocalizations.of(context).translate('name'),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: NameTextField(
                    controller: _nameController,
                    isNameInvalid: model.isNameInvalid,
                    onChanged: model.infoChanged,
                  ),
                ),
                SubHeader(
                  title: AppLocalizations.of(context).translate('amount'),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: AmountTextField(
                    controller: _amountController,
                    isAmountInvalid: model.isAmountInvalid,
                    onChanged: model.infoChanged,
                  ),
                ),
                SubHeader(
                  title: AppLocalizations.of(context).translate('nextDueDate'),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                SubHeader(
                  title: AppLocalizations.of(context).translate('category'),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: CategoryPickerBtn(
                    categoryId: model.recurringTransac.categoryId,
                    onPressed: () => model.openChooseCategoryPage(context),
                    width: double.infinity,
                    height: 80,
                    iconSize: 160,
                    iconBottomPosition: -75,
                  ),
                ),
                SubHeader(
                  title: AppLocalizations.of(context).translate('periodicity'),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
