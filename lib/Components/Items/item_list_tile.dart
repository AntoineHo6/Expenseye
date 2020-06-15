import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/theme_notifier.dart';
import 'package:Expenseye/Resources/Themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemListTile extends StatelessWidget {
  final Item item;
  final EdgeInsets contentPadding;
  final Function onPressed;
  final Color color;

  ItemListTile(this.item, {this.contentPadding, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    Color categoryColor = DbModel.catMap[item.categoryId].color;
    IconData iconData = DbModel.catMap[item.categoryId].iconData;
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return RaisedButton(
      color: color,
      elevation: 3,
      onPressed: onPressed,
      highlightColor: categoryColor.withOpacity(0.1),
      splashColor: categoryColor.withOpacity(0.1),
      child: ListTile(
        contentPadding: contentPadding,
        leading: Icon(
          iconData,
          color: categoryColor,
        ),
        title: Text(
          item.name,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        trailing: Text(
          item.type == ItemType.expense ? '- ${item.amount.toStringAsFixed(2)} \$' : '+ ${item.amount.toStringAsFixed(2)} \$',
          style: TextStyle(
            color: ColorChooserFromTheme.itemColorTypeChooser(
              item.type,
              themeNotifier.getTheme(),
            ),
          ),
        ),
      ),
    );
  }
}
