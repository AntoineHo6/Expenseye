import 'package:Expenseye/Models/Item.dart';

class TableCalendarUtil {
  
  static Map<DateTime, List<Item>> expensesToEvents(List<Item> expenses) {
    Map<DateTime, List<Item>> events = new Map();

    for (Item expense in expenses) {
      if (events.containsKey(expense.date)) {
        events[expense.date].add(expense);
      }
      else {
        events[expense.date] = new List();
        events[expense.date].add(expense);
      }
    }

    return events;
  }
}
