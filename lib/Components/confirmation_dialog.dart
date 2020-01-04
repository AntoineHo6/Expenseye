import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final int id;

  const ConfirmationDialog(this.id);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: MyColors.periwinkle,
      title: Text(Strings.confirm),
      content: Text(Strings.confirmMsg),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            Strings.cancelCaps,
          ),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            Strings.confirmCaps,
          ),
        ),
      ],
    );
  }
}
