import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartUtil {
  static List<charts.Series<ExpenseGroup, String>> convertExpensesToChartSeries(
      List<Item> items) {
    Map<String, ExpenseGroup> aggregatedExpenses = new Map();

    for (Item item in items) {
      if (item.type == ItemType.expense) {
        if (!aggregatedExpenses.containsKey(item.category)) {
          aggregatedExpenses[item.category] = ExpenseGroup(item.category);
        }
        aggregatedExpenses[item.category].total += item.value;
      }
    }

    return [
      new charts.Series(
          id: 'Expenses',
          domainFn: (ExpenseGroup group, _) => group.category,
          measureFn: (ExpenseGroup group, _) => group.total,
          colorFn: (ExpenseGroup group, _) => charts.ColorUtil.fromDartColor(
                DbModel.catMap[group.category].color,
              ),
          data: aggregatedExpenses.values.toList())
    ];
  }
}

class ExpenseGroup {
  String category;
  double total = 0;

  ExpenseGroup(this.category);
}
