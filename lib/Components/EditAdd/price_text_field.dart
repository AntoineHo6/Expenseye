import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';

class PriceTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPriceInvalid;
  final Function onChanged;

  const PriceTextField(
      {@required this.controller,
      @required this.isPriceInvalid,
      this.onChanged});

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
          hintText: Strings.price,
          hintStyle: TextStyle(color: MyColors.black24dp),
          errorText:
              isPriceInvalid ? Strings.price + ' ' + Strings.isInvalid : null,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
