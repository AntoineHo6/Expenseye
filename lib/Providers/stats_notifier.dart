import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Utils/chart_util.dart';
import 'package:flutter/material.dart';

class StatsNotifier extends ChangeNotifier {
  TransacType type = TransacType.expense;
  String currentSort = 'Amount';
  List<CategoryGroup> data;

  void switchChartType() {
    if (type == TransacType.expense) {
      type = TransacType.income;
    } else {
      type = TransacType.expense;
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
