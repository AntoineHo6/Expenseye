import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddExpenseFab extends StatelessWidget {
  final Function onExpensePressed;
  final Function onIncomePressed;

  AddExpenseFab({this.onExpensePressed, this.onIncomePressed});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      closeManually: false,
      elevation: 8,
      overlayOpacity: 0,
      child: const Icon(Icons.add),
      children: [
        SpeedDialChild(
          backgroundColor: Colors.red[400],
          child: const Icon(MdiIcons.currencyUsdCircle),
          label: AppLocalizations.of(context).translate('expense'),
          labelBackgroundColor: Theme.of(context).hintColor,
          labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
          onTap: onExpensePressed,
        ),
        SpeedDialChild(
          backgroundColor: Colors.green[400],
          child: const Icon(Icons.account_balance_wallet),
          label: AppLocalizations.of(context).translate('income'),
          labelBackgroundColor: Theme.of(context).hintColor,
          labelStyle: TextStyle(fontSize: 14.0, color: Colors.white),
          onTap: onIncomePressed,
        ),
      ],
    );
  }
}
