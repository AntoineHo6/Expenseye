import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:flutter/material.dart';

class ItemListTile extends StatelessWidget {
  final Item item;
  final EdgeInsets contentPadding;
  final Function onPressed;

  ItemListTile(this.item, {this.contentPadding, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // to compensate for weird bug occuring when changing the name of a category.
    // The first rebuild with query item's with the old id, then the second with query the up to date category ids
    // final Color color = DbModel.catMap[item.categoryId] != null
    //     ? DbModel.catMap[item.categoryId].color
    //     : Colors.yellow;
    // final IconData iconData = DbModel.catMap[item.categoryId] != null
    //     ? DbModel.catMap[item.categoryId].iconData
    //     : Icons.warning;

    Color color = DbModel.catMap[item.categoryId].color;
    IconData iconData = DbModel.catMap[item.categoryId].iconData;

    return RaisedButton(
      elevation: 8,
      color: item.type == ItemType.expense
          ? MyColors.expenseBGColor
          : MyColors.incomeBGColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: onPressed,
      highlightColor: color.withOpacity(0.1),
      splashColor: color.withOpacity(0.1),
      child: ListTile(
        contentPadding: contentPadding,
        leading: Icon(
          iconData,
          color: color,
        ),
        title: Text(
          item.name,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        trailing: Text(
          '${item.amount.toStringAsFixed(2)} \$',
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
    );
  }
}
