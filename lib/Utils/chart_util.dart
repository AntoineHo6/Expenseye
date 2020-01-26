import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Utils/item_category.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartUtil {
  static List<charts.Series<ExpenseGroup, String>>
      convertExpensesToChartSeries(List<Item> expenses) {
    List<ExpenseGroup> aggregatedExpenses = [
      new ExpenseGroup('food', 0),
      new ExpenseGroup('transportation', 0),
      new ExpenseGroup('shopping', 0),
      new ExpenseGroup('entertainment', 0),
      new ExpenseGroup('activity', 0),
      new ExpenseGroup('medical', 0),
      new ExpenseGroup('home', 0),
      new ExpenseGroup('travel', 0),
      new ExpenseGroup('people', 0),
      new ExpenseGroup('education', 0),
      new ExpenseGroup('others', 0),
    ];

    for (Item expense in expenses) {
      switch (expense.category) {
        case 'food':
          aggregatedExpenses[0].total += expense.value;
          break;
        case 'transportation':
          aggregatedExpenses[1].total += expense.value;
          break;
        case 'shopping':
          aggregatedExpenses[2].total += expense.value;
          break;
        case 'entertainment':
          aggregatedExpenses[3].total += expense.value;
          break;
        case 'activity':
          aggregatedExpenses[4].total += expense.value;
          break;
        case 'medical':
          aggregatedExpenses[5].total += expense.value;
          break;
        case 'home':
          aggregatedExpenses[6].total += expense.value;
          break;
        case 'travel':
          aggregatedExpenses[7].total += expense.value;
          break;
        case 'people':
          aggregatedExpenses[8].total += expense.value;
          break;
        case 'education':
          aggregatedExpenses[9].total += expense.value;
          break;
        case 'others':
          aggregatedExpenses[10].total += expense.value;
          break;
        case 'salary':
          break;
        case 'gift':
          break;
        case 'business':
          break;
        case 'insurance':
          break;
        case 'realEstate':
          break;
        case 'investment':
          break;
        case 'refund':
          break;
      }
    }

    return [
      new charts.Series(
          id: 'Expenses',
          domainFn: (ExpenseGroup group, _) => group.category,
          measureFn: (ExpenseGroup group, _) => group.total,
          colorFn: (ExpenseGroup group, _) => charts.ColorUtil.fromDartColor(
              ItemCategories.properties[group.category]['color']),
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
