import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartUtil {
  static List<charts.Series<CategoryGroup, String>> convertTransacsToChartSeries(
      List<Transac> transacs, TransacType type) {
    Map<String, CategoryGroup> aggregatedExpenses = new Map();

    for (Transac transac in transacs) {
      if (transac.type == type) {
        if (!aggregatedExpenses.containsKey(transac.categoryId)) {
          aggregatedExpenses[transac.categoryId] = CategoryGroup(transac.categoryId);
        }
        aggregatedExpenses[transac.categoryId].total += transac.amount;
      }
    }

    return [
      new charts.Series(
        id: 'transacs',
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
