import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:flutter/material.dart';

class MyThemeData {
  static final darkTheme = ThemeData(
    primaryColor: MyColors.black02dp,
    accentColor: MyColors.black02dp,
    backgroundColor: MyColors.black00dp,
    dialogBackgroundColor: MyColors.black00dp,
    scaffoldBackgroundColor: MyColors.black00dp,
    buttonColor: MyColors.black02dp,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: MyColors.secondary,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 32, color: Colors.white),
      headline2: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white),
      headline4: TextStyle(color: Colors.white),
      headline5: TextStyle(color: Colors.white),
      headline6: TextStyle(color: Colors.white),
      subtitle1: TextStyle(color: Colors.white),
      subtitle2: TextStyle(color: Colors.white),
      bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white),
      caption: TextStyle(color: Colors.white),
      button: TextStyle(color: Colors.white),
      overline: TextStyle(color: Colors.white),
    ),
  );
}
