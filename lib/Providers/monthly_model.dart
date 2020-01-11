import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Pages/Monthly/monthly_table_calendar_page.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:flutter/material.dart';

class MonthlyModel extends ChangeNotifier {
  DateTime currentDate = DateTime.now();
  String yearMonth = getYearMonthString(DateTime.now());
  double currentMonthsTotal = 0;

  static String getYearMonthString(DateTime newMonth) {
    String temp = newMonth.toIso8601String().split('T')[0];

    return temp.substring(0, temp.length - 3);
  }

  String getMonthlyTitle() {
    return '${DateTimeUtil.monthNames[currentDate.month]} ${currentDate.year}';
  }

  List<List<Expense>> splitExpensesByDay(List<Expense> expenses) {
    List<List<Expense>> expensesSplitByDay = new List();

    DateTime currentDate = expenses[0].date;
    int currentIndex = 0;
    expensesSplitByDay.add(List());

    for (Expense expense in expenses) {
      if (expense.date == currentDate) {
        expensesSplitByDay[currentIndex].add(expense);
      } else {
        currentIndex++;
        currentDate = expense.date;
        expensesSplitByDay.add(List());
        expensesSplitByDay[currentIndex].add(expense);
      }
    }
    return expensesSplitByDay;
  }

  void openMonthlyTableCalendarPage(BuildContext context) async {
    DateTime newDate = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MonthlyTableCalendarPage(currentDate)),
    );

    if (newDate != null) {
      currentDate = newDate;
      yearMonth = getYearMonthString(currentDate);
      //notifyListeners();
    }
  }
}
