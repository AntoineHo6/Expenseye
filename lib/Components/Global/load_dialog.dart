import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class LoadDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              width: 35,
            ),
            Text(AppLocalizations.of(context).translate('loading')),
          ],
        ),
      ),
    );
  }
}
