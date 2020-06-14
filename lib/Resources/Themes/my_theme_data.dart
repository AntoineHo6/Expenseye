import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:flutter/material.dart';

class MyThemeData {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    buttonColor: Colors.grey[200],
    primaryColor: Colors.grey[100],
    backgroundColor: Colors.white,
    dividerColor: Colors.black,
    focusColor: Colors.grey[600],
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.grey[200],
    accentColor: MyColors.secondaryDarker,
    hintColor: Colors.grey[400],
    // disabledColor: MyColors.secondaryDisabled,
    indicatorColor: MyColors.secondary,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: MyColors.secondary,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 32, color: Colors.black),
      headline2: TextStyle(color: Colors.black),
      headline3: TextStyle(color: Colors.black),
      headline4: TextStyle(color: Colors.black),
      headline5: TextStyle(color: Colors.black),
      headline6: TextStyle(color: Colors.black),
      subtitle1: TextStyle(color: Colors.black),
      subtitle2: TextStyle(color: Colors.black),
      bodyText1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.black),
      caption: TextStyle(color: Colors.grey),
      button: TextStyle(color: Colors.black),
      overline: TextStyle(color: Colors.black),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: Colors.white),
    buttonTheme: ButtonThemeData(
      buttonColor: MyColors.black06dp,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    primaryColor: MyColors.black02dp,
    dividerColor: Colors.white,
    backgroundColor: MyColors.black00dp,
    scaffoldBackgroundColor: MyColors.black00dp,
    cardColor: MyColors.black06dp,
    accentColor: MyColors.secondaryDarker,
    hintColor: MyColors.black24dp,
    disabledColor: MyColors.secondaryDisabled,
    indicatorColor: MyColors.secondary,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: MyColors.secondary,
    ),
    focusColor: Colors.white,
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
      caption: TextStyle(color: Colors.grey),
      button: TextStyle(color: Colors.white),
      overline: TextStyle(color: Colors.white),
    ),
  );
}
