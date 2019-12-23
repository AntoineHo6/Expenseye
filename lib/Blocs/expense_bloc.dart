import 'package:expense_app_beginner/Expense.dart';
import 'package:flutter/material.dart';

class ExpenseBloc extends ChangeNotifier {
  List<Expense> expenses;


  ExpenseBloc() {
    expenses = new List();
    addDefaultExpenses();
  }

  // ! TEMP method. to remove later
  void addDefaultExpenses() {
    for (var i = 1; i < 4; i++) {
      expenses.add(Expense('expense $i', 35));
    }
  }

  void addExpense(String name, double price) {
    expenses.add(Expense(name, price));
    notifyListeners();
  }

  void editExpense(Expense expense, {String title, double price, Image image}) {
    if (title != null) expense.title = title;
    if (price != null) expense.price = price;
    // * add image
    
    notifyListeners();
  }
}