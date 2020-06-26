import 'package:Expenseye/Pages/RecurringTransac/AddRecurringTransac/category_add_rec_transac_page.dart';
import 'package:Expenseye/Pages/RecurringTransac/AddRecurringTransac/date_add_rec_transac_page.dart';
import 'package:Expenseye/Pages/RecurringTransac/AddRecurringTransac/name_amount_add_rec_transac_page.dart';
import 'package:Expenseye/Pages/RecurringTransac/AddRecurringTransac/periodicity_add_rec_transac_page.dart';
import 'package:Expenseye/Pages/RecurringTransac/AddRecurringTransac/type_add_rec_transac_page.dart';
import 'package:Expenseye/Providers/RecurringTransac/add_recurring_transac_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRecurringTransacHomePage extends StatefulWidget {
  AddRecurringTransacHomePage();

  @override
  _AddRecurringTransacHomePageState createState() =>
      _AddRecurringTransacHomePageState();
}

class _AddRecurringTransacHomePageState
    extends State<AddRecurringTransacHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddRecurringTransacModel(),
      child: Consumer<AddRecurringTransacModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)
                .translate('addNewRecurringTransaction')),
          ),
          body: _currentStep(context),
        ),
      ),
    );
  }

  Widget _currentStep(BuildContext context) {
    final _addRecurringTransacModel = Provider.of<AddRecurringTransacModel>(context);
    switch (_addRecurringTransacModel.step) {
      case 1:
        return TypeAddRecTransacPage();
      case 2:
        return PeriodicityAddRecTransacPage();
      case 3:
        return DateAddRecTransacPage(_addRecurringTransacModel.periodicity);
      case 4:
        return NameAmountAddRecTransacPage();
      case 5:
        return CategoryAddRecTransacPage();
      default:
        return Align(
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context).translate('anErrorHasOccurred'),
          ),
        );
    }
  }
}
