import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class DateTimeUtil {
  static const Map<int, String> monthAbb = {
    1: 'Jan.',
    2: 'Feb.',
    3: 'Mar.',
    4: 'Apr.',
    5: 'May.',
    6: 'Jun.',
    7: 'jul.',
    8: 'Aug.',
    9: 'Sep.',
    10: 'Oct.',
    11: 'Nov.',
    12: 'Dec.'
  };

  // Keep DateTimes throughout the app uniform.
  // Only dates. No time. Local.
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

  static Future<DateTime> chooseMonth(
      BuildContext context, DateTime initialDate) async {
    DateTime newMonth = await showMonthPicker(
      context: context,
      initialDate: initialDate,
    );

    return newMonth;
  }

  static String formattedDate(DateTime date) {
    return '${DateTimeUtil.monthAbb[date.month]} ${date.day} ${date.year}';
  }
}
