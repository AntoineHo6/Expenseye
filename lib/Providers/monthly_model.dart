import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class MonthlyModel extends ChangeNotifier {
  DateTime currentDate;
  String yearMonthAbbr;
  String yearMonth;
  double currentTotal;
  double currentExpenseTotal;
  double currentIncomeTotal;
  int pageIndex;

  MonthlyModel(BuildContext context, DateTime date) {
    currentDate = date;
    updateYearMonthAbbr(context, currentDate);
    updateYearMonthString(currentDate);
    currentTotal = 0;
    currentExpenseTotal = 0;
    currentIncomeTotal = 0;
    pageIndex = 0;
  }

  void incrementMonth(BuildContext context) {
    int newMonth;
    int newYear = currentDate.year;
    if (currentDate.month == 12) {
      newMonth = 1;
      newYear = currentDate.year + 1;
    } else {
      newMonth = currentDate.month + 1;
    }

    updateDate(context, DateTime(newYear, newMonth));
  }

  void decrementMonth(BuildContext context) {
    int newMonth;
    int newYear = currentDate.year;

    if (currentDate.month == 1) {
      newMonth = 12;
      newYear = currentDate.year - 1;
    } else {
      newMonth = currentDate.month - 1;
    }

    updateDate(context, DateTime(newYear, newMonth));
  }

  void updateYearMonthAbbr(BuildContext context, DateTime newMonth) {
    yearMonthAbbr =
        '${AppLocalizations.of(context).translate(DateTimeUtil.monthAbb[newMonth.month])} ${newMonth.year}';
    // yearMonthAbbr =
    //     '${AppLocalizations.of(context).translate(DateTimeUtil.monthAbb[newMonth.month])}';
  }

  /// Returns String format of DateTime containing strictly it's month & year,
  ///  E.g. : '2020-06'.
  /// Used to query expenses that contain said String in it's date column.
  void updateYearMonthString(DateTime newMonth) {
    String temp = newMonth.toIso8601String().split('T')[0];

    yearMonth = temp.substring(0, temp.length - 3);
  }

  /// Returns the current date's month's full name and it's year in string
  /// format. E.g: 'January 2020'.
  String getTitle(BuildContext context) {
    return '${AppLocalizations.of(context).translate(DateTimeUtil.monthNames[currentDate.month])} ${currentDate.year}';
  }

  /// Returns nested lists of expenses seperated by day.
  /// E.g. : [ [01, 01], [03, 03, 03], [04] ] where each number represents an
  /// expense.
  List<List<Transac>> splitTransacsByDay(List<Transac> expenses) {
    List<List<Transac>> expensesSplitByDay = new List();

    DateTime currentDate = expenses[0].date;
    int index = 0;
    expensesSplitByDay.add(new List());

    for (Transac expense in expenses) {
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

  void updateDate(BuildContext context, DateTime newDate) {
    if (newDate != null) {
      currentDate = newDate;
      updateYearMonthString(currentDate);
      updateYearMonthAbbr(context, currentDate);
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
