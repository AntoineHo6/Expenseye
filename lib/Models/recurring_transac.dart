import 'package:Expenseye/Enums/periodicity.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/date_time_util.dart';

class RecurringTransac {
  int id;
  String name;
  double amount;
  DateTime dueDate; // corresponds to the next dueDate the item is due for
  Periodicity periodicity; // daily, weekly, bi-weekly, monthly, yearly
  String category;

  RecurringTransac(
    this.name,
    this.amount,
    this.dueDate,
    this.category,
    this.periodicity,
  );

  RecurringTransac.withId(
    this.id,
    this.name,
    this.amount,
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
        dueDate = DateTimeUtil.timeToZeroInDate(dueDate.add(Duration(days: 14)));
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
        dueDate = DateTimeUtil.timeToZeroInDate(DateTime(newYear, newMonth, dueDate.day));
        break;
      case Periodicity.yearly:
        dueDate = DateTimeUtil.timeToZeroInDate(DateTime(dueDate.year + 1, dueDate.month, dueDate.day));
        break;
    }
  }

  RecurringTransac.fromMap(Map<String, dynamic> map) {
    id = map[Strings.recurringItemColumnId];
    name = map[Strings.recurringItemColumnName];
    amount = map[Strings.recurringItemColumnAmount];
    dueDate = DateTime.parse(map[Strings.recurringItemColumnDueDate]);
    periodicity =
        Periodicity.values[map[Strings.recurringItemColumnPeriodicity]];
    category = map[Strings.recurringItemColumnCategory];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.recurringItemColumnName: name,
      Strings.recurringItemColumnAmount: amount,
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
