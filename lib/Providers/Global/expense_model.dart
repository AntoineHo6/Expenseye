import 'package:expense_app_beginner/Models/Expense.dart';
import 'package:expense_app_beginner/database_helpers.dart';
import 'package:flutter/material.dart';

class ExpenseModel extends ChangeNotifier {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  double calcTotal(List<Expense> expenses) {
    double total = 0;
    for (Expense expense in expenses) {
      total += expense.price;
    }

    return total;
  }

  void addExpense(String name, String price, DateTime date) {
    dbHelper.insert(new Expense(name, double.parse(price), date));
    notifyListeners();
  }

  void editExpense(int expenseId, {String name, String price, DateTime date}) {
    // if (name != null) expense.name = name;
    // if (price != null) expense.price = double.parse(price);
    // if (date != null) expense.date = date;

    dbHelper
        .update(new Expense.withId(expenseId, name, double.parse(price), date));

    notifyListeners();
  }

  String formattedDate(DateTime date) {
    return '${date.year} - ${date.month} - ${date.day}';
  }
}
