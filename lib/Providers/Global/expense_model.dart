import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Utils/database_helper.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:flutter/material.dart';

class ExpenseModel extends ChangeNotifier {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  // don't include todays time for uniform data
  DateTime dailyDate = DateTimeUtil.cleanDateTime(DateTime.now());

  void addExpense(Expense newExpense) {
    dbHelper.insert(newExpense);
    notifyListeners();
  }

  void editExpense(Expense newExpense) {
    dbHelper.update(newExpense);
    notifyListeners();
  }

  void deleteExpense(int id) {
    dbHelper.delete(id);
    notifyListeners();
  }

  double calcTotal(List<Expense> expenses) {
    double total = 0;
    for (Expense expense in expenses) {
      total += expense.price;
    }
    return total;
  }

  // * may move out of this provider
  String totalString(List<Expense> expenses) {
    return '${Strings.total}: ${calcTotal(expenses).toString()} \$';
  }

  String formattedDate(DateTime date) {
    return '${DateTimeUtil.monthAbb[date.month]} ${date.day} ${date.year}';
  }

  IconData catToIconData(ExpenseCategory category) {
    return CategoryProperties.properties[category]['iconData'];
  }

  void updateDate(DateTime newDate) {
    if (newDate != null) {
      dailyDate = newDate;
      notifyListeners();
    }
  }
}
