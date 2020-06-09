import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:flutter/material.dart';

class ItemListTile extends StatelessWidget {
  final Item item;
  final Function onTap;
  final EdgeInsets contentPadding;

  ItemListTile(this.item, {this.onTap, this.contentPadding});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding,
      leading: Icon(
        DbModel.catMap[item.category].iconData,
        color: DbModel.catMap[item.category].color,
      ),
      title: Text(
        item.name,
      ),
      trailing: Text(
        '${item.amount.toStringAsFixed(2)} \$',
      ),
      // subtitle: Text(item.category),
      onTap: onTap,
    );
  }
}
