import 'package:Expenseye/Components/EditAdd/Transac/add_transac_dialog.dart';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Pages/EditAddTransac/edit_transac_page.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class TransacModel extends ChangeNotifier {
  Future<void> showAddExpense(BuildContext context, DateTime initialDate) async {
    await showDialog(
      context: context,
      builder: (_) => AddTransacDialog(initialDate, TransacType.expense),
    );
  }

  Future<void> showAddIncome(BuildContext context, DateTime initialDate) async {
    await showDialog(
      context: context,
      builder: (_) => AddTransacDialog(initialDate, TransacType.income),
    );
  }

  Future<void> openEditTransac(BuildContext context, Transac transac) async {
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
