import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Utils/item_category.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartUtil {
  static List<charts.Series<ExpenseGroup, ItemCategory>>
      convertExpensesToChartSeries(List<Item> expenses) {
    List<ExpenseGroup> aggregatedExpenses = [
      new ExpenseGroup(ItemCategory.food, 0),
      new ExpenseGroup(ItemCategory.transportation, 0),
      new ExpenseGroup(ItemCategory.shopping, 0),
      new ExpenseGroup(ItemCategory.entertainment, 0),
      new ExpenseGroup(ItemCategory.activity, 0),
      new ExpenseGroup(ItemCategory.medical, 0),
      new ExpenseGroup(ItemCategory.home, 0),
      new ExpenseGroup(ItemCategory.travel, 0),
      new ExpenseGroup(ItemCategory.people, 0),
      new ExpenseGroup(ItemCategory.education, 0),
      new ExpenseGroup(ItemCategory.others, 0),
    ];

    for (Item expense in expenses) {
      switch (expense.category) {
        case ItemCategory.food:
          aggregatedExpenses[0].total += expense.value;
          break;
        case ItemCategory.transportation:
          aggregatedExpenses[1].total += expense.value;
          break;
        case ItemCategory.shopping:
          aggregatedExpenses[2].total += expense.value;
          break;
        case ItemCategory.entertainment:
          aggregatedExpenses[3].total += expense.value;
          break;
        case ItemCategory.activity:
          aggregatedExpenses[4].total += expense.value;
          break;
        case ItemCategory.medical:
          aggregatedExpenses[5].total += expense.value;
          break;
        case ItemCategory.home:
          aggregatedExpenses[6].total += expense.value;
          break;
        case ItemCategory.travel:
          aggregatedExpenses[7].total += expense.value;
          break;
        case ItemCategory.people:
          aggregatedExpenses[8].total += expense.value;
          break;
        case ItemCategory.education:
          aggregatedExpenses[9].total += expense.value;
          break;
        case ItemCategory.others:
          aggregatedExpenses[10].total += expense.value;
          break;
        case ItemCategory.salary:
          break;
        case ItemCategory.gift:
          break;
        case ItemCategory.business:
          break;
        case ItemCategory.insurance:
          break;
        case ItemCategory.refund:
          break;
      }
    }

    return [
      new charts.Series(
          id: 'Expenses',
          domainFn: (ExpenseGroup group, _) => group.category,
          measureFn: (ExpenseGroup group, _) => group.total,
          colorFn: (ExpenseGroup group, _) => charts.ColorUtil.fromDartColor(
              ItemCatProperties.properties[group.category]['color']),
          data: aggregatedExpenses)
    ];
  }
}

// can't implement map instead because charts use lists
class ExpenseGroup {
  ItemCategory category;
  double total;

  ExpenseGroup(this.category, this.total);
}
