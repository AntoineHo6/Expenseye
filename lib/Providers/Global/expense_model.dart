import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/database_helper.dart';
import 'package:flutter/material.dart';

class ExpenseModel extends ChangeNotifier {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  void addExpense(Expense newExpense) {
    dbHelper.insert(newExpense);
    notifyListeners();
  }

  void editExpense(Expense newExpense) {
    dbHelper.update(newExpense);

    notifyListeners();
  }

  double calcTotal(List<Expense> expenses) {
    double total = 0;
    for (Expense expense in expenses) {
      total += expense.price;
    }
    return total;
  }

  String totalString(List<Expense> expenses) {
    return '${Strings.total}: ${calcTotal(expenses).toString()} \$';
  }

  String formattedDate(DateTime date) {
    return '${date.year} - ${date.month} - ${date.day}';
  }
}