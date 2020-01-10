import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';

class AddExpenseFab extends StatelessWidget {
  final onPressed;

  AddExpenseFab({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: onPressed,
      elevation: 2,
      backgroundColor: MyColors.secondary,
    );
  }
}
