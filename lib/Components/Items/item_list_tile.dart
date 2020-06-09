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
    return RaisedButton(
      color: item.type == ItemType.expense
          ? MyColors.expenseBGColor
          : MyColors.incomeBGColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: onPressed,
      highlightColor: DbModel.catMap[item.category].color.withOpacity(0.2),
      splashColor: DbModel.catMap[item.category].color.withOpacity(0.2),
      child: ListTile(
        contentPadding: contentPadding,
        leading: Icon(
          DbModel.catMap[item.category].iconData,
          color: DbModel.catMap[item.category].color,
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
