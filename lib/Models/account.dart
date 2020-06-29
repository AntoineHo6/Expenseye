import 'package:Expenseye/Models/mdi_icon_data.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';

class Account {
  String id;
  String name;
  double balance;
  IconData iconData;

  Account(
    this.name,
    this.balance,
    this.iconData,
  );

  Account.withId(
    this.id,
    this.name,
    this.balance,
    this.iconData,
  );

  Account.fromMap(Map<String, dynamic> map) {
    id = map[Strings.accountColumnId];
    name = map[Strings.accountColumnName];
    balance = map[Strings.accountColumnBalance];
    iconData = MdiIconData(
      int.parse(map[Strings.accountColumnIconCodePoint], radix: 16),
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.accountColumnId: id,
      Strings.accountColumnName: name,
      Strings.accountColumnBalance: balance,
      Strings.accountColumnIconCodePoint: iconData.codePoint.toRadixString(16),
    };
    return map;
  }
}
