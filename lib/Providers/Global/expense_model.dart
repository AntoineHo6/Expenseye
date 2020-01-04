import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Utils/database_helper.dart';
import 'package:expense_app/Utils/expense_category.dart';
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

  // * may move out of this provider
  String totalString(List<Expense> expenses) {
    return '${Strings.total}: ${calcTotal(expenses).toString()} \$';
  }

  String formattedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  IconData catToIconData(ExpenseCategory category) {
    return CategoryProperties.properties[category]['iconData'];
  }
}
