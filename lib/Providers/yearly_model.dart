import 'package:expense_app/Models/Expense.dart';
import 'package:flutter/material.dart';

class YearlyModel extends ChangeNotifier {
  String year = getYearString(DateTime.now());
  double currentTotal = 0;

  static String getYearString(DateTime newYear) {
    String temp = newYear.toIso8601String().split('T')[0];

    return temp.substring(0, temp.length - 6);
  }

  // TODO: this is a dup from monthly_model crap
  String getYearMonthString(DateTime newMonth) {
    String temp = newMonth.toIso8601String().split('T')[0];

    return temp.substring(0, temp.length - 3);
  }

  List<List<Expense>> splitExpenseByMonth(List<Expense> expenses) {
    List<List<Expense>> expensesSplitByMonth = new List();

    String currentMonth = getYearMonthString(expenses[0].date);
    int index = 0;
    expensesSplitByMonth.add(new List());

    for (Expense expense in expenses) {
      if (getYearMonthString(expense.date) == currentMonth) {
        expensesSplitByMonth[index].add(expense);
        print('$currentMonth: ${expense.name}');
      }
      else {
        print('-------------------------');
        index++;
        currentMonth = getYearMonthString(expense.date);
        expensesSplitByMonth.add(new List());
        expensesSplitByMonth[index].add(expense);
        print('$currentMonth: ${expense.name}');
      }
    }

    return expensesSplitByMonth;
  }
}