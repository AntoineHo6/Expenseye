import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:flutter/material.dart';

class ItemListTile extends StatelessWidget {
  final Item item;
  final Function onTap;

  ItemListTile(this.item, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(ItemModel.categoriesMap[item.category].iconData,
          color: ItemModel.categoriesMap[item.category].color),
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
