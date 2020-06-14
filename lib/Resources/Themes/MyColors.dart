import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Resources/Themes/my_theme_data.dart';
import 'package:flutter/material.dart';

// TODO: rename
class MyColors {
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

  static const incomeBGColor = Color(0xff1C231B);
  static const incomeColor = Color(0xff316B28);
  static const expenseBGColor = Color(0xff231B1B);
  static const expenseColor = Color(0xff692626);
  static const balanceBGColor = Color(0xff2B2B1E);
}

class AppLightThemeColors {
  static const expenseBGColor = Color(0xFFFFE7E7);
  static const expenseColor = Color(0xffB94747);
  static const incomeBGColor = Color(0xFFEBFFE7);
  static const incomeColor = Color(0xff51B442);
  static const balanceBGColor = Color(0xFFFDFFC9);
}

class ColorChooserFromTheme {
  static itemColorTypeChooser(ItemType type, ThemeData theme) {
    if (type == ItemType.expense) {
      if (theme == MyThemeData.lightTheme) {
        return AppLightThemeColors.expenseColor;
      } else {
        return MyColors.expenseColor;
      }
    } else {
      if (theme == MyThemeData.lightTheme) {
        return AppLightThemeColors.incomeColor;
      } else {
        return MyColors.incomeColor;
      }
    }
  }

// TODO: change name with type
  static itemBGColorChooser(ItemType type, ThemeData theme) {
    if (type == ItemType.expense) {
      if (theme == MyThemeData.lightTheme) {
        return AppLightThemeColors.expenseBGColor;
      } else {
        return MyColors.expenseBGColor;
      }
    } else {
      if (theme == MyThemeData.lightTheme) {
        return AppLightThemeColors.incomeBGColor;
      } else {
        return MyColors.incomeBGColor;
      }
    }
  }

  static balanceBgColorChooser(ThemeData theme) {
    if (theme == MyThemeData.lightTheme) {
      return AppLightThemeColors.balanceBGColor;
    } else {
      return MyColors.balanceBGColor;
    }
  }
}
