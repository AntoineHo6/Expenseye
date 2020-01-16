import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Pages/Monthly/monthly_table_calendar_page.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';

class MonthlyModel extends ChangeNotifier {
  DateTime currentDate;
  String yearMonth;
  double currentTotal;
  int pageIndex = 0;

  MonthlyModel(DateTime date) {
    currentDate = date;
    yearMonth = getYearMonthString(currentDate);
    currentTotal = 0;
  }

  /// Returns String format of DateTime containing strictly it's month & year,
  ///  E.g. : '2020-06'.
  /// Used to query expenses that contain said String in it's date column.
  String getYearMonthString(DateTime newMonth) {
    String temp = newMonth.toIso8601String().split('T')[0];

    return temp.substring(0, temp.length - 3);
  }

  /// Returns the current date's month's full name and it's year in string
  /// format. E.g: 'January 2020'.
  String getTitle() {
    return '${DateTimeUtil.monthNames[currentDate.month]} ${currentDate.year}';
  }

  /// Returns nested lists of expenses seperated by day.
  /// E.g. : [ [01, 01], [03, 03, 03], [04] ] where each number represents an
  /// expense.
  List<List<Item>> splitItemsByDay(List<Item> expenses) {
    List<List<Item>> expensesSplitByDay = new List();

    DateTime currentDate = expenses[0].date;
    int index = 0;
    expensesSplitByDay.add(new List());

    for (Item expense in expenses) {
      if (expense.date == currentDate) {
        expensesSplitByDay[index].add(expense);
      } else {
        index++;
        currentDate = expense.date;
        expensesSplitByDay.add(new List());
        expensesSplitByDay[index].add(expense);
      }
    }
    return expensesSplitByDay;
  }

  /// On month chosen in the monthlyTableCalendarPage, update the current
  /// selected month.
  void calendarFunc(BuildContext context) async {
    DateTime newDate = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MonthlyTableCalendarPage(currentDate),
      ),
    );

    updateDate(context, newDate);
  }

  void updateDate(BuildContext context, DateTime newDate) {
    if (newDate != null) {
      currentDate = newDate;
      yearMonth = getYearMonthString(currentDate);
      notifyListeners();
    }
  }
}
