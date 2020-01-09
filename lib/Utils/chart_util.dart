import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartUtil {
  static List<charts.Series<ExpenseGroup, ExpenseCategory>>
      convertExpensesToChartSeries(List<Expense> expenses) {
    List<ExpenseGroup> aggregatedExpenses = [
      new ExpenseGroup(ExpenseCategory.food, 0),
      new ExpenseGroup(ExpenseCategory.transportation, 0),
      new ExpenseGroup(ExpenseCategory.shopping, 0),
      new ExpenseGroup(ExpenseCategory.entertainment, 0),
      new ExpenseGroup(ExpenseCategory.personal, 0),
      new ExpenseGroup(ExpenseCategory.medical, 0),
      new ExpenseGroup(ExpenseCategory.home, 0),
      new ExpenseGroup(ExpenseCategory.travel, 0),
      new ExpenseGroup(ExpenseCategory.people, 0),
      new ExpenseGroup(ExpenseCategory.others, 0),
    ];

    for (Expense expense in expenses) {
      switch (expense.category) {
        case ExpenseCategory.food:
          aggregatedExpenses[0].total += expense.price;
          break;
        case ExpenseCategory.transportation:
          aggregatedExpenses[1].total += expense.price;
          break;
        case ExpenseCategory.shopping:
          aggregatedExpenses[2].total += expense.price;
          break;
        case ExpenseCategory.entertainment:
          aggregatedExpenses[3].total += expense.price;
          break;
        case ExpenseCategory.personal:
          aggregatedExpenses[4].total += expense.price;
          break;
        case ExpenseCategory.medical:
          aggregatedExpenses[5].total += expense.price;
          break;
        case ExpenseCategory.home:
          aggregatedExpenses[6].total += expense.price;
          break;
        case ExpenseCategory.travel:
          aggregatedExpenses[7].total += expense.price;
          break;
        case ExpenseCategory.people:
          aggregatedExpenses[8].total += expense.price;
          break;
        case ExpenseCategory.others:
          aggregatedExpenses[9].total += expense.price;
          break;
      }
    }

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

// can't implement map instead because charts use lists
class ExpenseGroup {
  ExpenseCategory category;
  double total;

  ExpenseGroup(this.category, this.total);
}
