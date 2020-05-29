import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

// TODO: rename to AmountTextField
class PriceTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPriceInvalid;
  final Function onChanged;

  const PriceTextField({
    @required this.controller,
    @required this.isPriceInvalid,
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
          errorText: isPriceInvalid
              ? '${AppLocalizations.of(context).translate('priceIsInvalid')}'
              : null,
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }
}
