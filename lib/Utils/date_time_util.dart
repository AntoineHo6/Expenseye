import 'package:flutter/material.dart';

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

  static const Map<int, String> monthNames = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'july',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December'
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

  static Future<DateTime> chooseYear(BuildContext context, DateTime initialDate) async {
    DateTime newDate;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: YearPicker(
            selectedDate: initialDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2030),
            onChanged: (date) {
              newDate = date;
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );

    return newDate;
  }

  static String formattedDate(DateTime date) {
    return '${DateTimeUtil.monthAbb[date.month]} ${date.day} ${date.year}';
  }
}
