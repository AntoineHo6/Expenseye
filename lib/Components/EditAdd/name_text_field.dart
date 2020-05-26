import 'package:Expenseye/Resources/Themes/Colors.dart';
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
    return Theme(
      data: ThemeData(
        textTheme: Theme.of(context).textTheme,
        hintColor: Colors.white, // for the char counter
      ),
      child: TextField(
        maxLength: 50,
        controller: controller,
        onChanged: onChanged, // required for editExpensePage for save button
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: AppLocalizations.of(context).translate('name'),
          hintStyle: TextStyle(color: MyColors.black24dp),
          errorText: isNameInvalid
              ? '${AppLocalizations.of(context).translate('nameIsInvalid')}'
              : null,
        ),
      ),
    );
  }
}
