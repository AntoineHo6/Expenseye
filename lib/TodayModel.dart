import 'package:expense_app_beginner/Expense.dart';
import 'package:flutter/material.dart';

class TodayModel extends ChangeNotifier {
  List<Expense> expenses;
  int expenseCounter = 4;


  TodayModel() {
    expenses = new List();
    addDefaultExpenses();
  }

  void addDefaultExpenses() {
    for (var i = 1; i < 4; i++) {
      expenses.add(Expense('expense $i', 35));
    }
  }

  void addExpense(String name, double price) {
    expenses.add(Expense(name, price));
    notifyListeners();

    expenseCounter++;
  }
}