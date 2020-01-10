import 'package:expense_app/Pages/Daily/daily_table_calendar_page.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:flutter/material.dart';

class DailyModel extends ChangeNotifier {
  // don't include todays time for uniform data
  DateTime currentDate = DateTime.now();

  void openDailyTableCalendarPage(BuildContext context) async {
    DateTime newDate = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DailyTableCalendarPage(currentDate)),
    );

    if (newDate != null) {
      currentDate = newDate;
      notifyListeners();
    }
  }
}
