import 'package:expense_app_beginner/Resources/Strings.dart';

class Expense {
  int id;
  String name;
  double price;
  DateTime date;

  Expense(this.name, this.price, this.date);

  // convenience constructor to create a Expense object
  Expense.fromMap(Map<String, dynamic> map) {
    id = map[Strings.tableExpenses];
    name = map[Strings.columnName];
    price = map[Strings.columnPrice];
    date = DateTime.parse(map[Strings.columnDate]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.columnName: name,
      Strings.columnPrice: price,
      Strings.columnDate: date.toIso8601String(),
    };
    if (id != null) {
      map[Strings.columnId] = id;
    }
    return map;
  }
}
