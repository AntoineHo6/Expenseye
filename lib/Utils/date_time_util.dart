import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class DateTimeUtil {
  static const Map<int, String> monthAbb = {
    1: 'janAbbr',
    2: 'febAbbr',
    3: 'marAbbr',
    4: 'aprAbbr',
    5: 'mayAbbr',
    6: 'junAbbr',
    7: 'julAbbr',
    8: 'augAbbr',
    9: 'sepAbbr',
    10: 'octAbbr',
    11: 'novAbbr',
    12: 'decAbbr'
  };

  static const Map<int, String> monthNames = {
    1: 'jan',
    2: 'feb',
    3: 'mar',
    4: 'apr',
    5: 'may',
    6: 'jun',
    7: 'jul',
    8: 'aug',
    9: 'sep',
    10: 'oct',
    11: 'nov',
    12: 'dec'
  };

  /// Keep DateTimes throughout the app uniform, that is without time.
  /// prevents app from freaking out when comparing DateTime.
  static DateTime timeToZeroInDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static Future<DateTime> chooseDate(
      BuildContext context, DateTime initialDate) async {
    DateTime newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );

    return newDate;
  }

  static String formattedDate(BuildContext context, DateTime date) {
    switch (AppLocalizations.of(context).locale.languageCode) {
      case 'fr':
        return '${date.day} ${AppLocalizations.of(context).translate(DateTimeUtil.monthAbb[date.month])}, ${date.year}';
      default:
        // is english
        return '${AppLocalizations.of(context).translate(DateTimeUtil.monthAbb[date.month])} ${date.day}, ${date.year}';

    }
  }
}
