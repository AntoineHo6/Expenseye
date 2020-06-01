import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Pages/RecurrentItems/AddRecurrentItem/category_add_rec_item_page.dart';
import 'package:Expenseye/Pages/RecurrentItems/AddRecurrentItem/date_add_rec_item_page.dart';
import 'package:Expenseye/Pages/RecurrentItems/AddRecurrentItem/name_amount_add_rec_item_page.dart';
import 'package:Expenseye/Pages/RecurrentItems/AddRecurrentItem/periodicity_add_rec_item_page.dart';
import 'package:Expenseye/Pages/RecurrentItems/AddRecurrentItem/type_add_rec_item_page.dart';
import 'package:Expenseye/Providers/RecurrentItems/add_recurrent_item_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRecurrentItemHomePage extends StatefulWidget {
  AddRecurrentItemHomePage();

  @override
  _AddRecurrentItemHomePageState createState() =>
      _AddRecurrentItemHomePageState();
}

class _AddRecurrentItemHomePageState extends State<AddRecurrentItemHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddRecurrentItemModel(),
      child: Consumer<AddRecurrentItemModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Add new recurrent Item'), // TODO: use localization
          ),
          body: _currentStep(context),
        ),
      ),
    );
  }

  Widget _currentStep(BuildContext context) {
    final _addRecurrentItemModel = Provider.of<AddRecurrentItemModel>(context);
    switch (_addRecurrentItemModel.step) {
      case 1:
        return TypeAddRecItemPage();
      case 2:
        return PeriodicityAddRecItemPage();
      case 3:
        return DateAddRecItemPage(_addRecurrentItemModel.periodicity);
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
