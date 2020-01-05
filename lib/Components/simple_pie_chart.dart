import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Utils/expense_category.dart';
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
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList, animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Expense, ExpenseCategory>> _createSampleData() {
    final data = [
      new Expense('John Cena', 10, DateTime.now(), ExpenseCategory.people),
      //new Expense('Baguette', 5, DateTime.now(), ExpenseCategory.food),
      new Expense('Baguette', 3, DateTime.now(), ExpenseCategory.food),
      new Expense('Insulin', 10, DateTime.now(), ExpenseCategory.medical),
      new Expense('PS350', 3, DateTime.now(), ExpenseCategory.shopping),
    ];

    return [
      new charts.Series<Expense, ExpenseCategory>(
        id: 'Sales',
        domainFn: (Expense expense, _) => expense.category,
        measureFn: (Expense expense, _) => expense.price,
        colorFn: (Expense expense, _) => charts.ColorUtil.fromDartColor(
            CategoryProperties.properties[expense.category]['color']),
        data: data,
      )
    ];
  }
}
