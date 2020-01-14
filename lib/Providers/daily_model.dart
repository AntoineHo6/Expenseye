import 'package:expense_app/Pages/Daily/daily_table_calendar_page.dart';
import 'package:flutter/material.dart';

class DailyModel extends ChangeNotifier {
  DateTime currentDate = DateTime.now();
  double currentTotal = 0;
  int pageIndex = 0;

  void openDailyTableCalendarPage(BuildContext context) async {
    DateTime newDate = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DailyTableCalendarPage(currentDate),
      ),
    );

    // TODO: make this into a seperate function
    if (newDate != null) {
      currentDate = newDate;
      //notifyListeners();
    }
  }
}
