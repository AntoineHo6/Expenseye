import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Pages/EditAddTransac/edit_transac_page.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class Transac {
  int id;
  String name;
  double amount;
  DateTime date;
  String categoryId;
  TransacType type;

  Transac(
    this.name,
    this.amount,
    this.date,
    this.type,
    this.categoryId,
  );

  Transac.withId(
    this.id,
    this.name,
    this.amount,
    this.date,
    this.type,
    this.categoryId,
  );

  Transac.fromMap(Map<String, dynamic> map) {
    id = map[Strings.transacColumnId];
    name = map[Strings.transacColumnName];
    amount = map[Strings.transacColumnValue];
    date = DateTime.parse(map[Strings.transacColumnDate]);
    categoryId = map[Strings.transacColumnCategory];
    type = TransacType.values[map[Strings.transacColumnType]];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.transacColumnName: name,
      Strings.transacColumnValue: amount,
      Strings.transacColumnDate: date.toIso8601String(),
      Strings.transacColumnCategory: categoryId,
      Strings.transacColumnType: type.index
    };
    if (id != null) {
      map[Strings.transacColumnId] = id;
    }
    return map;
  }

  // todo: MOVE THIS THE FRICK OUTTTTT
  void openEditTransacPage(BuildContext context, Transac transac) async {
    int action = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditTransacPage(transac)),
    );

    if (action != null) {
      final snackBar = SnackBar(
        content: action == 1
            ? Text(AppLocalizations.of(context).translate('succEdited'))
            : Text(AppLocalizations.of(context).translate('succDeleted')),
        backgroundColor: Colors.grey.withOpacity(0.5),
      );

      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
