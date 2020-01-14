import 'package:flutter/material.dart';

class AddExpenseFab extends StatelessWidget {
  final Function onPressed;

  AddExpenseFab({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: onPressed,
      elevation: 2,
    );
  }
}
