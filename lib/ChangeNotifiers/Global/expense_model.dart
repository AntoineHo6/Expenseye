import 'package:expense_app_beginner/Models/Expense.dart';
import 'package:flutter/material.dart';

class ExpenseModel extends ChangeNotifier {
  List<Expense> allExpenses = new List();
  List<Expense> todaysExpenses = new List();

  ExpenseModel() {
    addDefaultExpenses();
  }

  // * TEMP method. to remove later
  void addDefaultExpenses() {
    for (var i = 1; i < 4; i++) {
      allExpenses.add(Expense('expense $i', 35, DateTime(2020)));
      todaysExpenses.add(Expense('expense $i', 35, DateTime(2020)));
    }
  }

  void addExpense(String name, String price, DateTime date) {
    allExpenses.add(Expense(name, double.parse(price), date));
    todaysExpenses.add(Expense(name, double.parse(price), date));
    notifyListeners();
  }

  void editExpense(Expense expense, {String name, String price}) {
    if (name != null) expense.name = name;
    if (price != null) expense.price = double.parse(price);
    
    notifyListeners();
  }

  double calcTodaysTotal() {
    double total = 0;
    for (Expense expense in todaysExpenses) {
      total += expense.price;
    }

    return total;
  }
}