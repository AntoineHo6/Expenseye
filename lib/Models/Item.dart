import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Pages/EditAddItem/edit_item_page.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class Item {
  int id;
  String name;
  double amount;
  DateTime date;
  int category;
  ItemType type;

  Item(
    this.name,
    this.amount,
    this.date,
    this.type,
    this.category,
  );

  Item.withId(
    this.id,
    this.name,
    this.amount,
    this.date,
    this.type,
    this.category,
  );

  Item.fromMap(Map<String, dynamic> map) {
    id = map[Strings.itemColumnId];
    name = map[Strings.itemColumnName];
    amount = map[Strings.itemColumnValue];
    date = DateTime.parse(map[Strings.itemColumnDate]);
    category = int.parse(map[Strings.itemColumnCategory]);
    type = ItemType.values[map[Strings.itemColumnType]];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Strings.itemColumnName: name,
      Strings.itemColumnValue: amount,
      Strings.itemColumnDate: date.toIso8601String(),
      Strings.itemColumnCategory: category,
      Strings.itemColumnType: type.index
    };
    if (id != null) {
      map[Strings.itemColumnId] = id;
    }
    return map;
  }

  // todo: MOVE THIS THE FRICK OUTTTTT
  void openEditItemPage(BuildContext context, Item item) async {
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
