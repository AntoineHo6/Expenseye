import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String msg;

  const ConfirmationDialog(this.msg);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).translate('confirm')),
      content: Text(msg),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context, false),
          textColor: Theme.of(context).focusColor,
          child: Text(AppLocalizations.of(context).translate('cancelCaps')),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context, true),
          textColor: Theme.of(context).focusColor,
          child: Text(AppLocalizations.of(context).translate('confirmCaps')),
        ),
      ],
    );
  }
}
