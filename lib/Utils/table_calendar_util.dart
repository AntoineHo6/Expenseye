import 'package:expense_app/Models/Expense.dart';

class TableCalendarUtil {
  
  static Map<DateTime, List<Expense>> expensesToEvents(List<Expense> expenses) {
    Map<DateTime, List<Expense>> events = new Map();

    for (Expense expense in expenses) {
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
