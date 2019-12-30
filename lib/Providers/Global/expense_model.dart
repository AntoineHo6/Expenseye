import 'package:expense_app_beginner/Models/Expense.dart';
import 'package:expense_app_beginner/database_helpers.dart';
import 'package:flutter/material.dart';

class ExpenseModel extends ChangeNotifier {
  List<Expense> allExpenses = new List();
  List<Expense> todaysExpenses = new List();

  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  ExpenseModel() {}

  double calcTotal(List<Expense> expenses) {
    double total = 0;
    for (Expense expense in expenses) {
      total += expense.price;
    }

    return total;
  }


  void addExpense(String name, String price, DateTime date) {
    // allExpenses.add(Expense(name, double.parse(price), date));
    // todaysExpenses.add(Expense(name, double.parse(price), date));
    // notifyListeners();
  }

  void editExpense(Expense expense,
      {String name, String price, DateTime date}) {
    if (name != null) expense.name = name;
    if (price != null) expense.price = double.parse(price);
    if (date != null) expense.date = date;
    
    notifyListeners();
  }

  // double calcTodaysTotal() {
  //   double total = 0;
  //   for (Expense expense in todaysExpenses) {
  //     total += expense.price;
  //   }

  //   return total;
  // }

  String dateToString(DateTime date) {
    return '${date.year} - ${date.month} - ${date.day}';
  }
}
