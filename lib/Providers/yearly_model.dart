import 'package:Expenseye/Models/Transac.dart';
import 'package:flutter/material.dart';

class YearlyModel extends ChangeNotifier {
  DateTime currentDate = DateTime.now(); // to be changed in the year picker
  String year = getYearString(DateTime.now());
  int pageIndex = 0;

  void decrementYear() {
    currentDate = currentDate.subtract(Duration(days: 365));
    year = getYearString(currentDate);
    notifyListeners();
  }

  void incrementYear() {
    currentDate = currentDate.add(Duration(days: 365));
    year = getYearString(currentDate);
    notifyListeners();
  }

  static String getYearString(DateTime newYear) {
    String temp = newYear.toIso8601String().split('T')[0];
    return temp.substring(0, temp.length - 6);
  }

  String getYearMonthString(DateTime newMonth) {
    String temp = newMonth.toIso8601String().split('T')[0];
    return temp.substring(0, temp.length - 3);
  }

  List<List<Transac>> splitTransacsByMonth(List<Transac> transacs) {
    List<List<Transac>> expensesSplitByMonth = new List();

    if (transacs.length > 0) {
      String currentMonth = getYearMonthString(transacs[0].date);
      int index = 0;
      expensesSplitByMonth.add(new List());

      for (Transac expense in transacs) {
        if (getYearMonthString(expense.date) == currentMonth) {
          expensesSplitByMonth[index].add(expense);
        } else {
          index++;
          currentMonth = getYearMonthString(expense.date);
          expensesSplitByMonth.add(new List());
          expensesSplitByMonth[index].add(expense);
        }
      }
    }

    return expensesSplitByMonth;
  }

  void updateCurrentDate(BuildContext context, DateTime newDate) {
    if (newDate != null) {
      currentDate = newDate;
      year = getYearString(newDate);
      notifyListeners();
    }
  }

  String getTitle(BuildContext context) {
    return year;
  }
}
