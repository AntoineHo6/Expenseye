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
    id = map[Strings.itemColumnId];
    name = map[Strings.itemColumnName];
    amount = map[Strings.itemColumnValue];
    date = DateTime.parse(map[Strings.itemColumnDate]);
    categoryId = map[Strings.itemColumnCategory];
    type = TransacType.values[map[Strings.itemColumnType]];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.itemColumnName: name,
      Strings.itemColumnValue: amount,
      Strings.itemColumnDate: date.toIso8601String(),
      Strings.itemColumnCategory: categoryId,
      Strings.itemColumnType: type.index
    };
    if (id != null) {
      map[Strings.itemColumnId] = id;
    }
    return map;
  }

  // todo: MOVE THIS THE FRICK OUTTTTT
  void openEditItemPage(BuildContext context, Transac item) async {
    int action = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditItemPage(item)),
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
