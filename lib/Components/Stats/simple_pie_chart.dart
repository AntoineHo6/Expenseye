import 'package:charts_flutter/flutter.dart' as charts;
import 'package:Expenseye/Utils/chart_util.dart';
import 'package:Expenseye/Utils/expense_category.dart';
import 'package:flutter/material.dart';

class SimplePieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimplePieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory SimplePieChart.withSampleData() {
    return new SimplePieChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList, animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<ExpenseGroup, ExpenseCategory>>
      _createSampleData() {
    List<ExpenseGroup> aggregatedExpenses = [
      new ExpenseGroup(ExpenseCategory.food, 5),
      new ExpenseGroup(ExpenseCategory.transportation, 0),
      new ExpenseGroup(ExpenseCategory.shopping, 8),
      new ExpenseGroup(ExpenseCategory.entertainment, 0),
      new ExpenseGroup(ExpenseCategory.activity, 0),
      new ExpenseGroup(ExpenseCategory.medical, 1),
      new ExpenseGroup(ExpenseCategory.home, 3),
      new ExpenseGroup(ExpenseCategory.travel, 7),
      new ExpenseGroup(ExpenseCategory.people, 1),
      new ExpenseGroup(ExpenseCategory.others, 2),
    ];
    return [
      new charts.Series(
          id: 'Expenses',
          domainFn: (ExpenseGroup group, _) => group.category,
          measureFn: (ExpenseGroup group, _) => group.total,
          colorFn: (ExpenseGroup group, _) => charts.ColorUtil.fromDartColor(
              CategoryProperties.properties[group.category]['color']),
          data: aggregatedExpenses)
    ];
  }
}
