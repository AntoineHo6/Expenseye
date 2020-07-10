import 'package:Expenseye/Resources/Themes/my_theme_data.dart';
import 'package:flutter/material.dart';

class AppDarkThemeColors {
  static const Color black00dp = Color(0xff121212);
  static const Color black01dp = Color(0xff1d1d1d);
  static const Color black02dp = Color(0xff212121);
  static const Color black03dp = Color(0xff242424);
  static const Color black06dp = Color(0xff2c2c2c);
  static const Color black12dp = Color(0xff323232);
  static const Color black24dp = Color(0xff373737);
  static const Color secondaryLight = Color(0xff38C6B9);
  static const Color secondary = Color(0xff33B4A8);
  static const Color secondaryDarker = Color(0xff227069);
  static const Color secondaryDisabled = Color(0xff0D2F2C);

  static const incomeColor = Color(0xff81d645);
  static const expenseColor = Color(0xffd64545);
  static const balanceColor = Colors.yellow;
}

class AppLightThemeColors {
  static const expenseColor = Color(0xffB94747);
  static const incomeColor = Color(0xff459c38);
  static final balanceColor = Colors.yellow[800];
}

class ColorChooserFromTheme {
  static Color expenseColor;
  static Color incomeColor;
  static Color balanceColor;

  ColorChooserFromTheme(ThemeData theme) {
    if (theme == MyThemeData.lightTheme) {
      expenseColor = AppLightThemeColors.expenseColor;
      incomeColor = AppLightThemeColors.incomeColor;
      balanceColor = AppLightThemeColors.balanceColor;
    } else {
      expenseColor = AppDarkThemeColors.expenseColor;
      incomeColor = AppDarkThemeColors.incomeColor;
      balanceColor = AppDarkThemeColors.balanceColor;
    }
  }
}
