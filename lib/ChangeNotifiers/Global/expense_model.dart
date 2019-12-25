import 'package:expense_app_beginner/Models/Expense.dart';
import 'package:flutter/material.dart';

class ExpenseModel extends ChangeNotifier {
  List<Expense> expenses;


  ExpenseModel() {
    expenses = new List();
    addDefaultExpenses();
  }

  // * TEMP method. to remove later
  void addDefaultExpenses() {
    for (var i = 1; i < 4; i++) {
      expenses.add(Expense('expense $i', 35));
    }
  }

  void addExpense(String name, String price) {
    expenses.add(Expense(name, double.parse(price)));
    notifyListeners();
  }

  void editExpense(Expense expense, {String name, String price, Image image}) {
    if (name != null) expense.name = name;
    if (price != null) expense.price = double.parse(price);
    // add image
    
    notifyListeners();
  }
}