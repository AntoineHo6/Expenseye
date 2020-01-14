import 'package:expense_app/Resources/Strings.dart';
import 'package:flutter/material.dart';

class DeleteConfirmDialog extends StatelessWidget {
  
  const DeleteConfirmDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(Strings.confirm),
      content: const Text(Strings.confirmMsg),
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
