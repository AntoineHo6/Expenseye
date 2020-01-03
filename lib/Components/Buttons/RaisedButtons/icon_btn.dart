import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';

class IconBtn extends RaisedButton {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: MyColors.indigoInk,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 4.0,
      onPressed: () => print('John wick'),
      child: Icon(Icons.fastfood),
    );
  }
}
