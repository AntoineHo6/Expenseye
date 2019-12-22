import 'package:expense_app_beginner/Expense.dart';
import 'package:flutter/material.dart';

class ExpenseBloc extends ChangeNotifier {
  List<Expense> expenses;
  int expenseCounter = 4;


  ExpenseBloc() {
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

  void editExpense(Expense expense, {String title, double price, String note, Image image}) {
    if (price != null) expense.price = price;

    if (note != null) expense.note = note;
    
    notifyListeners();
  }
}