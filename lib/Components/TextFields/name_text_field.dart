import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';

class NameTextField extends StatelessWidget {
  final controller;
  final isNameInvalid;
  final onChanged;

  const NameTextField({this.controller, this.isNameInvalid, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 50,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: Strings.name,
        hintStyle: TextStyle(color: MyColors.black24dp),
        errorText:
            isNameInvalid ? Strings.name + ' ' + Strings.isInvalid : null,
      ),
    );
  }
}
