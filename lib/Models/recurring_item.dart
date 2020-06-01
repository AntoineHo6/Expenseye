import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Resources/Strings.dart';

class RecurringItem {
  int id;
  String name;
  double value;
  DateTime dueDate; // corresponds to the next dueDate the item is due for
  Periodicity periodicity; // daily, weekly, bi-weekly, monthly, yearly
  String category;

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
        dueDate = dueDate.add(Duration(days: 1));
        break;
      case Periodicity.weekly:
        dueDate = dueDate.add(Duration(days: 7));
        break;
      case Periodicity.biweekly:
        dueDate = dueDate.add(Duration(days: 14));
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
        dueDate = DateTime(newYear, newMonth, dueDate.day);
        break;
      case Periodicity.yearly:
        dueDate = DateTime(dueDate.year + 1, dueDate.month, dueDate.day);
        break;
    }
  }

  RecurringItem.fromMap(Map<String, dynamic> map) {
    id = map[Strings.recurringItemColumnId];
    name = map[Strings.recurringItemColumnName];
    value = map[Strings.recurringItemColumnValue];
    dueDate = DateTime.parse(map[Strings.recurringItemColumnDueDate]);
    periodicity =
        Periodicity.values[map[Strings.recurringItemColumnPeriodicity]];
    category = map[Strings.recurringItemColumnCategory];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.recurringItemColumnName: name,
      Strings.recurringItemColumnValue: value,
      Strings.recurringItemColumnDueDate: dueDate.toIso8601String(),
      Strings.recurringItemColumnPeriodicity: periodicity.index,
      Strings.recurringItemColumnCategory: category
    };
    if (id != null) {
      map[Strings.recurringItemColumnId] = id;
    }
    return map;
  }
}
