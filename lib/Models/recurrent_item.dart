import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Resources/Strings.dart';

class RecurrentItem {
  int id;
  String name;
  double value;
  DateTime date; // corresponds to the next date the item is due for
  int isAdded;
  Periodicity periodicity; // daily, weekly, bi-weekly, monthly, yearly
  String category;

  RecurrentItem(this.name, this.value, this.date, this.isAdded, this.category,
      this.periodicity);

  RecurrentItem.withId(this.id, this.name, this.value, this.date, this.isAdded,
      this.category, this.periodicity);

  void updateDueDate() {
    switch (periodicity) {
      case Periodicity.daily:
        date = date.add(Duration(days: 1));
        break;
      case Periodicity.weekly:
        date = date.add(Duration(days: 7));
        break;
      case Periodicity.biweekly:
        date = date.add(Duration(days: 14));
        break;
      case Periodicity.monthly:
        int newMonth;
        int newYear = date.year;
        if (date.month == 12) {
          newMonth = 1;
          newYear = date.year + 1;
        } else {
          newMonth = date.month + 1;
        }
        date = DateTime(newYear, newMonth, date.day);
        break;
      case Periodicity.yearly:
        date = DateTime(date.year + 1, date.month, date.day);
        break;
    }
  }

  RecurrentItem.fromMap(Map<String, dynamic> map) {
    id = map[Strings.recurrentItemColumnId];
    name = map[Strings.recurrentItemColumnName];
    value = map[Strings.recurrentItemColumnValue];
    date = DateTime.parse(map[Strings.recurrentItemColumnDate]);
    isAdded = map[Strings.recurrentItemColumnIsAdded];
    periodicity =
        Periodicity.values[map[Strings.recurrentItemColumnPeriodicity]];
    category = map[Strings.recurrentItemColumnCategory];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.recurrentItemColumnName: name,
      Strings.recurrentItemColumnValue: value,
      Strings.recurrentItemColumnDate: date.toIso8601String(),
      Strings.recurrentItemColumnIsAdded: isAdded,
      Strings.recurrentItemColumnPeriodicity: periodicity.index,
      Strings.recurrentItemColumnCategory: category
    };
    if (id != null) {
      map[Strings.recurrentItemColumnId] = id;
    }
    return map;
  }
}
