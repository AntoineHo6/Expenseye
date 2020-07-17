import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Models/account.dart';
import 'package:Expenseye/Providers/Global/db_notifier.dart';
import 'package:Expenseye/Resources/Themes/app_colors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class TransacListTile extends StatelessWidget {
  final Transac transac;
  final EdgeInsets contentPadding;
  final Function onPressed;
  final Color color;
  final bool dense;

  TransacListTile(
    this.transac, {
    this.contentPadding,
    this.onPressed,
    this.color,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    Category category = DbNotifier.catMap[transac.categoryId] ?? null;
    Account account = DbNotifier.accMap[transac.accountId] ?? null;

    Color categoryColor = category != null ? category.color : Colors.yellow;
    IconData iconData = category != null ? category.iconData : Icons.warning;
    String accountName =
        account != null ? account.name : AppLocalizations.of(context).translate('error');

    return RaisedButton(
      color: color,
      elevation: 3,
      onPressed: onPressed,
      highlightColor: categoryColor.withOpacity(0.2),
      splashColor: categoryColor.withOpacity(0.2),
      child: ListTile(
        dense: dense,
        contentPadding: contentPadding,
        leading: Icon(
          iconData,
          color: categoryColor,
        ),
        title: Text(
          transac.name,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        trailing: Text(
          transac.type == TransacType.expense
              ? '-${transac.amount.toStringAsFixed(2)} \$'
              : '+${transac.amount.toStringAsFixed(2)} \$',
          style: TextStyle(
            color: transac.type == TransacType.expense
                ? ColorChooserFromTheme.expenseColor
                : ColorChooserFromTheme.incomeColor,
          ),
        ),
        subtitle: Text(accountName),
      ),
    );
  }
}
