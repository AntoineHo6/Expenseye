import 'package:Expenseye/Components/EditAdd/Transac/add_transac_dialog.dart';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Pages/EditAddTransac/edit_transac_page.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class TransacModel extends ChangeNotifier {
  void showAddExpense(BuildContext context, DateTime initialDate) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => AddTransacDialog(initialDate, TransacType.expense),
    );

    if (confirmed != null && confirmed) {
      showSuccAddedSnackBar(context);
    }
  }

  void showAddIncome(BuildContext context, DateTime initialDate) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => AddTransacDialog(initialDate, TransacType.income),
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

  Future<void> openEditItem(BuildContext context, Transac item) async {
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

  void calcTotals(dynamic model, List<Transac> items) {
    double total = 0;
    double expenseTotal = 0;
    double incomeTotal = 0;

    for (var item in items) {
      switch (item.type) {
        case TransacType.expense:
          expenseTotal += item.amount;
          total -= item.amount;
          break;
        case TransacType.income:
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

  double calcItemsTotal(List<Transac> items) {
    double total = 0;

    for (var item in items) {
      switch (item.type) {
        case TransacType.expense:
          total -= item.amount;
          break;
        case TransacType.income:
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
