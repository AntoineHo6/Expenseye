import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Utils/item_category.dart';
import 'package:flutter/material.dart';

class ItemListTile extends StatelessWidget {
  final Item item;
  final Function onTap;

  ItemListTile(this.item, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Categories.map[item.category].iconData,
          color: Categories.map[item.category].color),
      title: Text(
        item.name,
      ),
      trailing: Text(
        '${item.value.toStringAsFixed(2)} \$',
      ),
      //subtitle: Text(item.category),
      onTap: onTap,
    );
  }
}
