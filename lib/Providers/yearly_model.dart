import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:flutter/material.dart';

class YearlyModel extends ChangeNotifier {
  DateTime currentDate = DateTime.now(); // to be changed in the year picker
  String year = getYearString(DateTime.now());
  double currentTotal = 0;
  double currentExpenseTotal = 0;
  double currentIncomeTotal = 0;
  int pageIndex = 0;
  ItemType chartType = ItemType.expense;

  void switchChartType() {
    if (chartType == ItemType.expense) {
      chartType = ItemType.income;
    } else {
      chartType = ItemType.expense;
    }

    notifyListeners();
  }

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

  List<List<Item>> splitItemByMonth(List<Item> expenses) {
    List<List<Item>> expensesSplitByMonth = new List();

    String currentMonth = getYearMonthString(expenses[0].date);
    int index = 0;
    expensesSplitByMonth.add(new List());

    for (Item expense in expenses) {
      if (getYearMonthString(expense.date) == currentMonth) {
        expensesSplitByMonth[index].add(expense);
      } else {
        index++;
        currentMonth = getYearMonthString(expense.date);
        expensesSplitByMonth.add(new List());
        expensesSplitByMonth[index].add(expense);
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

  void resetTotals() {
    currentTotal = 0;
    currentIncomeTotal = 0;
    currentExpenseTotal = 0;

    notifyListeners();
  }
}
