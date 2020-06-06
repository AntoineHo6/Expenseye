import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/date_time_util.dart';

class RecurringItem {
  int id;
  String name;
  double value;
  DateTime dueDate; // corresponds to the next dueDate the item is due for
  Periodicity periodicity; // daily, weekly, bi-weekly, monthly, yearly
  Category category;

  RecurringItem(
    this.name,
    this.value,
    this.dueDate,
    this.category,
    this.periodicity,
  );

  RecurringItem.withId(
    this.id,
    this.name,
    this.value,
    this.dueDate,
    this.category,
    this.periodicity,
  );

  void updateDueDate() {
    switch (periodicity) {
      case Periodicity.daily:
        dueDate = DateTimeUtil.timeToZeroInDate(dueDate.add(Duration(days: 1)));
        break;
      case Periodicity.weekly:
        dueDate = DateTimeUtil.timeToZeroInDate(dueDate.add(Duration(days: 7)));
        break;
      case Periodicity.biweekly:
        dueDate =
            DateTimeUtil.timeToZeroInDate(dueDate.add(Duration(days: 14)));
        break;
      case Periodicity.monthly:
        int newMonth;
        int newYear = dueDate.year;
        if (dueDate.month == 12) {
          newMonth = 1;
          newYear = dueDate.year + 1;
        } else {
          newMonth = dueDate.month + 1;
        }
        dueDate = DateTimeUtil.timeToZeroInDate(
            DateTime(newYear, newMonth, dueDate.day));
        break;
      case Periodicity.yearly:
        dueDate = DateTimeUtil.timeToZeroInDate(
            DateTime(dueDate.year + 1, dueDate.month, dueDate.day));
        break;
    }
  }

  static Future<RecurringItem> fromMap(Map<String, dynamic> map) async {
    int id = map[Strings.recurringItemColumnId];
    String name = map[Strings.recurringItemColumnName];
    double value = map[Strings.recurringItemColumnAmount];
    DateTime dueDate = DateTime.parse(map[Strings.recurringItemColumnDueDate]);
    Periodicity periodicity =
        Periodicity.values[map[Strings.recurringItemColumnPeriodicity]];
    Category category = await DatabaseHelper.instance.queryCategoryById(map[Strings.recurringItemColumnCategory]);

    return RecurringItem.withId(id, name, value, dueDate, category, periodicity);
  }

  // RecurringItem.fromMap(Map<String, dynamic> map) {
  //   id = map[Strings.recurringItemColumnId];
  //   name = map[Strings.recurringItemColumnName];
  //   value = map[Strings.recurringItemColumnAmount];
  //   dueDate = DateTime.parse(map[Strings.recurringItemColumnDueDate]);
  //   periodicity =
  //       Periodicity.values[map[Strings.recurringItemColumnPeriodicity]];
  //   category = Category.fromMap(map[Strings.recurringItemColumnCategory]);
  // }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.recurringItemColumnName: name,
      Strings.recurringItemColumnAmount: value,
      Strings.recurringItemColumnDueDate: dueDate.toIso8601String(),
      Strings.recurringItemColumnPeriodicity: periodicity.index,
      Strings.recurringItemColumnCategory: category.id
    };
    if (id != null) {
      map[Strings.recurringItemColumnId] = id;
    }
    return map;
  }
}
