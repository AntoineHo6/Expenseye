import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/expense_category.dart';

class Expense {
  int id;
  String name;
  double price;
  DateTime date;
  ExpenseCategory category;

  Expense(this.name, this.price, this.date, this.category);

  Expense.withId(this.id, this.name, this.price, this.date, this.category);

  Expense.fromMap(Map<String, dynamic> map) {
    id = map[Strings.expenseColumnId];
    name = map[Strings.expenseColumnName];
    price = map[Strings.expenseColumnPrice];
    date = DateTime.parse(map[Strings.expenseColumnDate]);
    category = ExpenseCategory.values[map[Strings.expenseColumnCategory]];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.expenseColumnName: name,
      Strings.expenseColumnPrice: price,
      Strings.expenseColumnDate: date.toIso8601String(),
      Strings.expenseColumnCategory: category.index
    };
    if (id != null) {
      map[Strings.expenseColumnId] = id;
    }
    return map;
  }
}
