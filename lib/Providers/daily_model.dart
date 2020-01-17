import 'package:Expenseye/Pages/Daily/daily_table_calendar_page.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';

class DailyModel extends ChangeNotifier {
  DateTime currentDate = DateTime.now();
  double currentTotal = 0;
  double currentExpenseTotal = 0;
  double currentIncomeTotal = 0;
  int pageIndex = 0;

  String getTitle() {
    return DateTimeUtil.formattedDate(currentDate);
  }

  void calendarFunc(BuildContext context) async {
    DateTime newDate = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DailyTableCalendarPage(currentDate),
      ),
    );

    updateDate(context, newDate);
  }

  void updateDate(BuildContext context, DateTime newDate) {
    if (newDate != null) {
      currentDate = newDate;
      notifyListeners();
    }
  }

  void resetTotals() {
    currentTotal = 0;
    currentIncomeTotal = 0;
    currentExpenseTotal = 0;

    notifyListeners();
  }
}
