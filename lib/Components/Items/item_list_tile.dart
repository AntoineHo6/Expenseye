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
      leading: Icon(ItemCategories.properties[item.category]['iconData'],
          color: ItemCategories.properties[item.category]['color']),
      title: Text(
        item.name,
      ),
      trailing: Text(
        '${item.value.toStringAsFixed(2)} \$',
      ),
      subtitle: Text(item.category),
      onTap: onTap,
    );
  }
}
