import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Pages/EditAddItem/choose_category_page.dart';
import 'package:Expenseye/Pages/RecurrentItems/category_add_rec_item_page.dart';
import 'package:Expenseye/Pages/RecurrentItems/date_add_rec_item_page.dart';
import 'package:Expenseye/Pages/RecurrentItems/name_amount_add_rec_item_page.dart';
import 'package:Expenseye/Pages/RecurrentItems/periodicity_add_rec_item_page.dart';
import 'package:Expenseye/Providers/RecurrentItems/add_recurrent_item_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRecurrentItemHomePage extends StatelessWidget {
  final ItemType type;

  AddRecurrentItemHomePage(this.type);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddRecurrentItemModel(type),
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
        return PeriodicityAddRecItemPage();
      case 2:
        return DateAddRecItemPage(_addRecurrentItemModel.periodicity);
      case 3:
        return NameAmountAddRecItemPage();
      case 4:
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
