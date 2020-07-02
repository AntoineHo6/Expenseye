import 'package:Expenseye/Resources/Strings.dart';

class Account {
  String id;
  String name;
  double balance;

  Account(
    this.id,
    this.name,
    this.balance,
  );

  Account.fromMap(Map<String, dynamic> map) {
    id = map[Strings.accountColumnId];
    name = map[Strings.accountColumnName];
    balance = map[Strings.accountColumnBalance];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.accountColumnId: id,
      Strings.accountColumnName: name,
      Strings.accountColumnBalance: balance,
    };
    return map;
  }
}
