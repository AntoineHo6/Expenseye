import 'package:expense_app/Resources/Strings.dart';

class Expense {
  int id;
  String name;
  double price;
  DateTime date;
  int icon; // * should be Icon

  Expense(this.name, this.price, this.date);

  Expense.withId(this.id, this.name, this.price, this.date);

  Expense.fromMap(Map<String, dynamic> map) {
    id = map[Strings.columnId];
    name = map[Strings.columnName];
    price = map[Strings.columnPrice];
    date = DateTime.parse(map[Strings.columnDate]);
    icon = map[Strings.columnIcon]; // * should convert id to Icon
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.columnName: name,
      Strings.columnPrice: price,
      Strings.columnDate: date.toIso8601String(),
      Strings.columnIcon: 1  // * temp. should get id of the icon instead
    };
    if (id != null) {
      map[Strings.columnId] = id;
    }
    return map;
  }
}
