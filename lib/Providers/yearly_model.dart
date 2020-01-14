import 'package:Expenseye/Models/Expense.dart';
import 'package:Expenseye/Providers/home_page_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearlyModel extends ChangeNotifier {
  DateTime currentDate = DateTime.now();  // to be changed in the year picker
  String year = getYearString(DateTime.now());
  double currentTotal = 0;
  int pageIndex = 0;

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
      }
      else {
        index++;
        currentMonth = getYearMonthString(expense.date);
        expensesSplitByMonth.add(new List());
        expensesSplitByMonth[index].add(expense);
      }
    }

    return expensesSplitByMonth;
  }

  void updateCurrentDate(BuildContext context, DateTime newDate) {
    currentDate = newDate;
    year = getYearString(newDate);

    Provider.of<HomePageModel>(context, listen: false).updateAppBar(
        newAppBarTitle: year,
      );

    notifyListeners();
  }

  String getTitle() {
    return year;
  }

  void calendarFunc(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: YearPicker(
            selectedDate: currentDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2030),
            onChanged: (date) {
              updateCurrentDate(context, date);
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}