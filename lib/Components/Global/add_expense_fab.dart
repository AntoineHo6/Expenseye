import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AddExpenseFab extends StatelessWidget {
  final Function onExpensePressed;
  final Function onIncomePressed;

  AddExpenseFab({this.onExpensePressed, this.onIncomePressed});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      overlayOpacity: 0,
      child: Icon(Icons.add),
      children: [
        SpeedDialChild(
          backgroundColor: Colors.red,
          child: Icon(Icons.attach_money),
          onTap: onExpensePressed,
        ),
        SpeedDialChild(
          backgroundColor: Colors.green,
          child: Icon(Icons.account_balance_wallet),
          onTap: onIncomePressed,
        ),
      ],
    );

    // return FloatingActionButton(
    //   child: const Icon(Icons.add),
    //   onPressed: onPressed,
    //   elevation: 2,
    // );
  }
}
