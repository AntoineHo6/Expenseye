import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Utils/expense_category.dart';

class Expense {
  int id;
  String name;
  double price;
  DateTime date;
  ExpenseCategory category;

  Expense(this.name, this.price, this.date, this.category);

  Expense.withId(this.id, this.name, this.price, this.date, this.category);

  Expense.fromMap(Map<String, dynamic> map) {
    id = map[Strings.columnId];
    name = map[Strings.columnName];
    price = map[Strings.columnPrice];
    date = DateTime.parse(map[Strings.columnDate]);
    category = ExpenseCategory.values[map[Strings.columnCategory]];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.columnName: name,
      Strings.columnPrice: price,
      Strings.columnDate: date.toIso8601String(),
      Strings.columnCategory: category.index
    };
    if (id != null) {
      map[Strings.columnId] = id;
    }
    return map;
  }
}
