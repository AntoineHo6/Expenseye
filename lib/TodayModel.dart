import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TodayModel extends ChangeNotifier {
  static const String title = 'Today\'s expenses';
  List<String> expenses = ['expense 1', 'expense 2', 'expense 3'];
  //List<String> get expenses => _expenses;


  void addExpense() {
    expenses.add('new expense');
    notifyListeners();
  }
}