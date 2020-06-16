import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartUtil {
  static List<charts.Series<CategoryGroup, String>> convertItemsToChartSeries(
      List<Item> items, ItemType type) {
    Map<String, CategoryGroup> aggregatedExpenses = new Map();

    for (Item item in items) {
      if (item.type == type) {
        if (!aggregatedExpenses.containsKey(item.categoryId)) {
          aggregatedExpenses[item.categoryId] = CategoryGroup(item.categoryId);
        }
        aggregatedExpenses[item.categoryId].total += item.amount;
      }
    }

    return [
      new charts.Series(
        id: 'items',
        domainFn: (CategoryGroup group, _) => group.category.toString(),
        measureFn: (CategoryGroup group, _) => group.total,
        colorFn: (CategoryGroup group, _) => charts.ColorUtil.fromDartColor(
          DbModel.catMap[group.category].color,
        ),
        data: aggregatedExpenses.values.toList(),
        labelAccessorFn: (CategoryGroup row, _) => '${row.category}',
      )
    ];
  }
}

class CategoryGroup {
  String category;
  double total = 0;

  CategoryGroup(this.category);
}
