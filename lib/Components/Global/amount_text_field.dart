import 'package:Expenseye/Resources/Themes/MyColors.dart';
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
    return Theme(
      data: ThemeData(
        textTheme: Theme.of(context).textTheme,
        hintColor: Colors.white,
      ),
      child: TextField(
        maxLength: 10,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: AppLocalizations.of(context).translate('amount'),
          hintStyle: const TextStyle(color: MyColors.black24dp),
          errorText: isAmountInvalid
              ? '${AppLocalizations.of(context).translate('amountIsInvalid')}'
              : null,
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }
}
