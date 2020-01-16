import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/income_category.dart';

class Income {
  int id;
  String name;
  double amount;
  DateTime date;
  IncomeCategory category;

  Income(this.name, this.amount, this.date, this.category);

  Income.withId(this.id, this.name, this.amount, this.date, this.category);

  Income.fromMap(Map<String, dynamic> map) {
    id = map[Strings.incomeColumnId];
    name = map[Strings.incomeColumnName];
    amount = map[Strings.incomeColumnAmount];
    date = DateTime.parse(map[Strings.incomeColumnDate]);
    category = IncomeCategory.values[map[Strings.incomeColumnCategory]];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.incomeColumnName: name,
      Strings.incomeColumnAmount: amount,
      Strings.incomeColumnDate: date.toIso8601String(),
      Strings.incomeColumnCategory: category.index
    };
    if (id != null) {
      map[Strings.incomeColumnId] = id;
    }
    return map;
  }
}
