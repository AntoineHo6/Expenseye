import 'package:Expenseye/Pages/RecurringItems/AddRecurringItem/category_add_rec_item_page.dart';
import 'package:Expenseye/Pages/RecurringItems/AddRecurringItem/date_add_rec_item_page.dart';
import 'package:Expenseye/Pages/RecurringItems/AddRecurringItem/name_amount_add_rec_item_page.dart';
import 'package:Expenseye/Pages/RecurringItems/AddRecurringItem/periodicity_add_rec_item_page.dart';
import 'package:Expenseye/Pages/RecurringItems/AddRecurringItem/type_add_rec_item_page.dart';
import 'package:Expenseye/Providers/RecurringItems/add_recurring_item_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRecurringItemHomePage extends StatefulWidget {
  AddRecurringItemHomePage();

  @override
  _AddRecurringItemHomePageState createState() =>
      _AddRecurringItemHomePageState();
}

class _AddRecurringItemHomePageState extends State<AddRecurringItemHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddRecurringItemModel(),
      child: Consumer<AddRecurringItemModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).translate('addNewRecurringItem')),
          ),
          body: _currentStep(context),
        ),
      ),
    );
  }

  Widget _currentStep(BuildContext context) {
    final _addRecurringItemModel = Provider.of<AddRecurringItemModel>(context);
    switch (_addRecurringItemModel.step) {
      case 1:
        return TypeAddRecItemPage();
      case 2:
        return PeriodicityAddRecItemPage();
      case 3:
        return DateAddRecItemPage(_addRecurringItemModel.periodicity);
      case 4:
        return NameAmountAddRecItemPage();
      case 5:
        return CategoryAddRecItemPage();
      default:
        return Align(
          alignment: Alignment.center,
          child: Text(
              AppLocalizations.of(context).translate('anErrorHasOccurred')),
        );
    }
  }
}
