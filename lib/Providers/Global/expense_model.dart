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

  // * may move out of this provider
  String totalString(List<Expense> expenses) {
    return '${Strings.total}: ${calcTotal(expenses).toString()} \$';
  }

  String formattedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  IconData indexToIconData(int index) {
    switch (index) {
      case 0:
        return Icons.restaurant;
      case 1:
        return Icons.directions_car;
      case 2:
        return Icons.shopping_cart;
        case 3:
        return Icons.movie;
        case 4:
        return Icons.face;
        case 5:
        return Icons.healing;
        case 6:
        return Icons.home;
        case 7:
        return Icons.airplanemode_active;
        case 8:
        return Icons.people;
        case 9:
        return Icons.tab;
    }
  }
}
