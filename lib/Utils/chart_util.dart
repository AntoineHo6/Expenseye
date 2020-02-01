import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/item_category.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartUtil {
  static List<charts.Series<ExpenseGroup, String>> convertExpensesToChartSeries(
      List<Item> expenses) {
    List<ExpenseGroup> aggregatedExpenses = [
      new ExpenseGroup(Strings.food, 0),
      new ExpenseGroup(Strings.transportation, 0),
      new ExpenseGroup(Strings.shopping, 0),
      new ExpenseGroup(Strings.entertainment, 0),
      new ExpenseGroup(Strings.activity, 0),
      new ExpenseGroup(Strings.medical, 0),
      new ExpenseGroup(Strings.home, 0),
      new ExpenseGroup(Strings.travel, 0),
      new ExpenseGroup(Strings.people, 0),
      new ExpenseGroup(Strings.education, 0),
      new ExpenseGroup(Strings.others, 0),
    ];

    for (Item expense in expenses) {
      switch (expense.category) {
        case Strings.food:
          aggregatedExpenses[0].total += expense.value;
          break;
        case Strings.transportation:
          aggregatedExpenses[1].total += expense.value;
          break;
        case Strings.shopping:
          aggregatedExpenses[2].total += expense.value;
          break;
        case Strings.entertainment:
          aggregatedExpenses[3].total += expense.value;
          break;
        case Strings.activity:
          aggregatedExpenses[4].total += expense.value;
          break;
        case Strings.medical:
          aggregatedExpenses[5].total += expense.value;
          break;
        case Strings.home:
          aggregatedExpenses[6].total += expense.value;
          break;
        case Strings.travel:
          aggregatedExpenses[7].total += expense.value;
          break;
        case Strings.travel:
          aggregatedExpenses[8].total += expense.value;
          break;
        case Strings.education:
          aggregatedExpenses[9].total += expense.value;
          break;
        case Strings.others:
          aggregatedExpenses[10].total += expense.value;
          break;
      }
    }

    return [
      new charts.Series(
          id: 'Expenses',
          domainFn: (ExpenseGroup group, _) => group.category,
          measureFn: (ExpenseGroup group, _) => group.total,
          colorFn: (ExpenseGroup group, _) => charts.ColorUtil.fromDartColor(
                Categories.map[group.category].color,
              ),
          data: aggregatedExpenses)
    ];
  }
}

// can't implement map instead because charts use lists
class ExpenseGroup {
  String category;
  double total;

  ExpenseGroup(this.category, this.total);
}
