import 'package:flutter/material.dart';

class CategoriesModel extends ChangeNotifier {
  List<String> selectedExpenses = new List();
  List<String> selectedIncomes = new List();
}