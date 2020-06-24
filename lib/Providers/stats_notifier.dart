import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Utils/chart_util.dart';
import 'package:flutter/material.dart';

class StatsNotifier extends ChangeNotifier {
  ItemType type = ItemType.expense;
  String currentSort = 'Amount';
  List<CategoryGroup> data;

  void switchChartType() {
    if (type == ItemType.expense) {
      type = ItemType.income;
    } else {
      type = ItemType.expense;
    }

    notifyListeners();
  }

  void changeCurrentSort(String newSort) {
    currentSort = newSort;
    notifyListeners();
  }

  void sortCategoryGroups() {
    switch (currentSort) {
      case 'Name':
      data.sort((a, b) => a.category.compareTo(b.category));
        break;
      case 'Amount':
        data.sort((b, a) => a.total.compareTo(b.total));
        break;
    }
  }
}
