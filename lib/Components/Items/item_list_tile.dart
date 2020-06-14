import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/theme_notifier.dart';
import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemListTile extends StatelessWidget {
  final Item item;
  final EdgeInsets contentPadding;
  final Function onPressed;

  ItemListTile(this.item, {this.contentPadding, this.onPressed});

  @override
  Widget build(BuildContext context) {
    Color categoryColor = DbModel.catMap[item.categoryId].color;
    IconData iconData = DbModel.catMap[item.categoryId].iconData;
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return RaisedButton(
      color: ColorChooserFromTheme.itemBGColorChooser(
        item.type,
        themeNotifier.getTheme(),
      ),
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
          '${item.amount.toStringAsFixed(2)} \$',
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
    );
  }
}
