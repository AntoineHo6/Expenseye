import 'package:expense_app/Pages/table_calendar_page.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:flutter/material.dart';

class DailyModel extends ChangeNotifier {
  // don't include todays time for uniform data
  DateTime currentDate = DateTimeUtil.timeToZeroInDate(DateTime.now());

  void openTableCalendarPage(BuildContext context) async {
    DateTime newDate = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TableCalendarPage(currentDate)),
    );

    if (newDate != null) {
      currentDate = newDate;
      notifyListeners();
    }
  }
}