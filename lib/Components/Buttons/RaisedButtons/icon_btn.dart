import 'package:expense_app/Pages/icons_page.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';

class IconBtn extends RaisedButton {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: MyColors.blueberry,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 3.0,
      onPressed: () => _openIconsPage(context),
      child: Icon(Icons.fastfood),
    );
  }

  void _openIconsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => IconsPage()),
    );
  }
}
