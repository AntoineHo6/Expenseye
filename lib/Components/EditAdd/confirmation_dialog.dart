import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final String msg;

  const DeleteConfirmDialog(this.msg);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(Strings.confirm),
      content: Text(msg),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context, false),
          textColor: Colors.white,
          child: const Text(
            Strings.cancelCaps,
          ),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context, true),
          textColor: Colors.white,
          child: const Text(
            Strings.confirmCaps,
          ),
        ),
      ],
    );
  }
}
