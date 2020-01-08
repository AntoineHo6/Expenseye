import 'package:expense_app/Models/Expense.dart';

class TableCalendarUtil {
  // List<Expense> to Map<DateTime, List<Expense>>

  // ! Makes sure query is ordered by date
  static Map<DateTime, List<Expense>> expensesToEvents(List<Expense> expenses) {
    
    Map<DateTime, List<Expense>> events = new Map();

    String currentTempsDate = '';
    List<Expense> temp = new List();

    for (var expense in expenses) {
      if (expense.date.toIso8601String().split('T')[0] == currentTempsDate) {
        temp.add(expense);
      }
      else {
        if (temp.isNotEmpty) events[temp[0].date] = new List<Expense>.from(temp);

        temp.clear();

        currentTempsDate = expense.date.toIso8601String().split('T')[0];
        temp.add(expense);
      }
    }

    if (temp.isNotEmpty) events[temp[0].date] = new List<Expense>.from(temp);
    

    return events;
  }
}
