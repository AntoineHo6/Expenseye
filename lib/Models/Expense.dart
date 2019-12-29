import 'package:expense_app_beginner/Resources/Strings.dart';

class Expense {
  int id;
  String name;
  double price;
  DateTime date;

  Expense(this.name, this.price, this.date);

  // convenience constructor to create a Word object
  Expense.fromMap(Map<String, dynamic> map) {
    id = map[Strings.tableExpenses];
    name = map[Strings.columnName];
    price = map[Strings.columnPrice];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.columnName: name,
      Strings.columnPrice: price
    };
    if (id != null) {
      map[Strings.columnId] = id;
    }
    return map;
  }
}
