import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';

class PriceTextField extends StatelessWidget {
  final controller;
  final isPriceInvalid;
  final onChanged;

  const PriceTextField({this.controller, this.isPriceInvalid, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 10,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: Strings.price,
        hintStyle: TextStyle(color: MyColors.black24dp),
        errorText:
            isPriceInvalid ? Strings.price + ' ' + Strings.isInvalid : null,
      ),
      keyboardType: TextInputType.number,
    );
  }
}
