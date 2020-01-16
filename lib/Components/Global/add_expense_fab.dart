import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';

class AddExpenseFab extends StatelessWidget {
  final Function onPressed;

  AddExpenseFab({this.onPressed});

  @override
  Widget build(BuildContext context) {
    var childButtons = new List<UnicornButton>();

    childButtons.add(
      UnicornButton(
        currentButton: FloatingActionButton(
          mini: true,
          child: Icon(Icons.account_balance_wallet),
          onPressed: () => print('Open add income'),
          backgroundColor: Colors.green,
        ),
      ),
    );

    childButtons.add(
      UnicornButton(
        currentButton: FloatingActionButton(
          mini: true,
          child: Icon(Icons.attach_money),
          onPressed: onPressed,
          backgroundColor: Colors.indigo,
        ),
      ),
    );

    return UnicornDialer(
      hasBackground: false,
      parentButton: Icon(Icons.add),
      childButtons: childButtons,
    );
  }
}
