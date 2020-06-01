import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Resources/Strings.dart';

class RecurrentItem {
  int id;
  String name;
  double value;
  DateTime dueDate; // corresponds to the next dueDate the item is due for
  Periodicity periodicity; // daily, weekly, bi-weekly, monthly, yearly
  String category;

  RecurrentItem(
    this.name,
    this.value,
    this.dueDate,
    this.category,
    this.periodicity,
  );

  RecurrentItem.withId(
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

  RecurrentItem.fromMap(Map<String, dynamic> map) {
    id = map[Strings.recurrentItemColumnId];
    name = map[Strings.recurrentItemColumnName];
    value = map[Strings.recurrentItemColumnValue];
    dueDate = DateTime.parse(map[Strings.recurrentItemColumnDueDate]);
    periodicity =
        Periodicity.values[map[Strings.recurrentItemColumnPeriodicity]];
    category = map[Strings.recurrentItemColumnCategory];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.recurrentItemColumnName: name,
      Strings.recurrentItemColumnValue: value,
      Strings.recurrentItemColumnDueDate: dueDate.toIso8601String(),
      Strings.recurrentItemColumnPeriodicity: periodicity.index,
      Strings.recurrentItemColumnCategory: category
    };
    if (id != null) {
      map[Strings.recurrentItemColumnId] = id;
    }
    return map;
  }
}
