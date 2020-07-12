import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Models/Transac.dart';

class TransacUtil {
  /// Returns nested lists of transactions seperated by day.
  /// E.g. : [ [01, 01], [03, 03, 03], [04] ] where each number represents a
  /// transaction.
  static List<List<Transac>> splitTransacsByDay(List<Transac> transactions) {
    List<List<Transac>> transacsSplitByDay = new List();

    if (transactions.length > 0) {
      transactions.sort((b, a) => a.date.compareTo(b.date));

      DateTime currentDate = transactions[0].date;
      int index = 0;
      transacsSplitByDay.add(new List());

      for (Transac transac in transactions) {
        if (transac.date == currentDate) {
          transacsSplitByDay[index].add(transac);
        } else {
          index++;
          currentDate = transac.date;
          transacsSplitByDay.add(new List());
          transacsSplitByDay[index].add(transac);
        }
      }
    }

    return transacsSplitByDay;
  }

  static double calcTransacsTotal(List<Transac> transacs) {
    double total = 0;

    for (var transac in transacs) {
      switch (transac.type) {
        case TransacType.expense:
          total -= transac.amount;
          break;
        case TransacType.income:
          total += transac.amount;
          break;
      }
    }

    return total;
  }
}
