import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class AmountTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isAmountInvalid;
  final Function onChanged;

  const AmountTextField({
    @required this.controller,
    @required this.isAmountInvalid,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 10,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).hintColor,
            width: 0.5,
          ),
        ),
        hintText: AppLocalizations.of(context).translate('amount'),
        errorText: isAmountInvalid
            ? '${AppLocalizations.of(context).translate('amountIsInvalid')}'
            : null,
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );
  }
}
