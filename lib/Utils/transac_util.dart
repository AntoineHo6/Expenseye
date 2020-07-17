import 'package:Expenseye/Components/EditAdd/Transac/add_transac_dialog.dart';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Pages/EditAddTransac/edit_transac_page.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class TransacUtil {
  /// Returns nested lists of transactions seperated by day.
  /// E.g. : [ [01, 01], [03, 03, 03], [04] ] where each number represents a
  /// transaction.
  static List<List<Transac>> splitTransacsByDay(List<Transac> transactions) {
    List<List<Transac>> transacsSplitByDay = new List();

    if (transactions.length > 0) {
      transactions.sort((b, a) => a.date.compareTo(b.date));

      DateTime currentDate = transactions[0].date;
      int index = 0;
      transacsSplitByDay.add(new List());

      for (Transac transac in transactions) {
        if (transac.date == currentDate) {
          transacsSplitByDay[index].add(transac);
        } else {
          index++;
          currentDate = transac.date;
          transacsSplitByDay.add(new List());
          transacsSplitByDay[index].add(transac);
        }
      }
    }

    return transacsSplitByDay;
  }

  static double calcTransacsTotal(List<Transac> transacs) {
    double total = 0;

    for (var transac in transacs) {
      switch (transac.type) {
        case TransacType.expense:
          total -= transac.amount;
          break;
        case TransacType.income:
          total += transac.amount;
          break;
      }
    }

    return total;
  }

  static Future<void> showAddTransacDialog(
      BuildContext context, DateTime initialDate, TransacType type) async {
    await showDialog(
      context: context,
      builder: (_) => AddTransacDialog(initialDate, type),
    );
  }

  static Future<void> openEditTransacPage(BuildContext context, Transac transac) async {
    int action = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditTransacPage(transac)),
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
}
