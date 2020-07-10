import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Resources/Strings.dart';

class Transac {
  int id;
  String name;
  double amount;
  DateTime date;
  String categoryId;
  TransacType type;
  String accountId;

  Transac(
    this.name,
    this.amount,
    this.date,
    this.type,
    this.categoryId,
    this.accountId,
  );

  Transac.withId(
    this.id,
    this.name,
    this.amount,
    this.date,
    this.type,
    this.categoryId,
    this.accountId,
  );

  Transac.fromMap(Map<String, dynamic> map) {
    id = map[Strings.transacColumnId];
    name = map[Strings.transacColumnName];
    amount = map[Strings.transacColumnValue];
    date = DateTime.parse(map[Strings.transacColumnDate]);
    type = TransacType.values[map[Strings.transacColumnType]];
    categoryId = map[Strings.transacColumnCategory];
    accountId = map[Strings.transacColumnAccount];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.transacColumnName: name,
      Strings.transacColumnValue: amount,
      Strings.transacColumnDate: date.toIso8601String(),
      Strings.transacColumnType: type.index,
      Strings.transacColumnCategory: categoryId,
      Strings.transacColumnAccount: accountId,
    };
    if (id != null) {
      map[Strings.transacColumnId] = id;
    }
    return map;
  }
}
