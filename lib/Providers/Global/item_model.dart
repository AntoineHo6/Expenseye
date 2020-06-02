import 'package:Expenseye/Components/EditAddItem/add_item_dialog.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Pages/EditAddItem/edit_item_page.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class ItemModel extends ChangeNotifier {
  void showAddExpense(BuildContext context, DateTime initialDate) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => AddItemDialog(initialDate, ItemType.expense),
    );

    if (confirmed != null && confirmed) {
      showSuccAddedSnackBar(context);
    }
  }

  void showAddIncome(BuildContext context, DateTime initialDate) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => AddItemDialog(initialDate, ItemType.income),
    );

    if (confirmed != null && confirmed) {
      showSuccAddedSnackBar(context);
    }
  }

  void showSuccAddedSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(AppLocalizations.of(context).translate('succAdded')),
      backgroundColor: Colors.grey.withOpacity(0.5),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  void openEditItem(BuildContext context, Item item) async {
    int action = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditItemPage(item)),
    );

    if (action != null) {
      final snackBar = SnackBar(
        content: action == 1
            ? Text(AppLocalizations.of(context).translate('succEdited'))
            : Text(AppLocalizations.of(context).translate('succDeleted')),
        backgroundColor: Colors.grey.withOpacity(0.5),
      );

      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void calcTotals(dynamic model, List<Item> items) {
    double total = 0;
    double expenseTotal = 0;
    double incomeTotal = 0;

    for (var item in items) {
      switch (item.type) {
        case ItemType.expense:
          expenseTotal += item.amount;
          total -= item.amount;
          break;
        case ItemType.income:
          incomeTotal += item.amount;
          total += item.amount;
          break;
      }
    }

    model.currentTotal = total;
    model.currentExpenseTotal = expenseTotal;
    model.currentIncomeTotal = incomeTotal;

    //notifyListeners();
  }

  double calcItemsTotal(List<Item> items) {
    double total = 0;

    for (var item in items) {
      switch (item.type) {
        case ItemType.expense:
          total -= item.amount;
          break;
        case ItemType.income:
          total += item.amount;
          break;
      }
    }

    return total;
  }

  // * may move out of this provider
  String totalString(double total) {
    return '${total.toStringAsFixed(2)} \$';
  }
}
