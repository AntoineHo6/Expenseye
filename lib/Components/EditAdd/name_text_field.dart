import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class NameTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isNameInvalid;
  final Function onChanged;

  const NameTextField(
      {@required this.controller,
      @required this.isNameInvalid,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 50,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).focusColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).hintColor,
            width: 0.5,
          ),
        ),
        hintText: AppLocalizations.of(context).translate('name'),
        errorText: isNameInvalid
            ? '${AppLocalizations.of(context).translate('nameIsInvalid')}'
            : null,
      ),
    );
  }
}
