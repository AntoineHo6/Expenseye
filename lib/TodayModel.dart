import 'package:expense_app_beginner/Expense.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TodayModel extends ChangeNotifier {
  static const String title = 'Today\'s expenses';
  List<Expense> expenses;
  int expenseCounter = 4;


  TodayModel() {
    expenses = new List();
    addDefaultExpenses();
  }

  void addDefaultExpenses() {
    for (var i = 1; i < 4; i++) {
      expenses.add(Expense('expense $i', 35, DateTime.now()));
    }
  }

  void addExpense() {
    expenses.add(Expense('expense $expenseCounter', 21, DateTime.now()));
    notifyListeners();

    expenseCounter++;
  }
}