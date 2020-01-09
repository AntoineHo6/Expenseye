import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Utils/database_helper.dart';
import 'package:flutter/material.dart';

// rename to localDbModel
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

  void deleteExpense(int id) {
    dbHelper.delete(id);
    notifyListeners();
  }

  double _calcTotal(List<Expense> expenses) {
    double total = 0;
    for (Expense expense in expenses) {
      total += expense.price;
    }
    return total;
  }

  // * may move out of this provider
  String totalString(List<Expense> expenses) {
    return '${Strings.total}: ${_calcTotal(expenses).toString()} \$';
  }

}
