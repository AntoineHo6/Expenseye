import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Models/account.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/settings_notifier.dart';
import 'package:Expenseye/Resources/Themes/app_colors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO: rename to btn
class TransacListTile extends StatelessWidget {
  final Transac transac;
  final EdgeInsets contentPadding;
  final Function onPressed;
  final Color color;

  TransacListTile(this.transac, {this.contentPadding, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    Category category = DbModel.catMap[transac.categoryId] ?? null;
    Account account = DbModel.accMap[transac.accountId] ?? null;

    Color categoryColor = category != null ? category.color : Colors.yellow;
    IconData iconData = category != null ? category.iconData : Icons.warning;
    String accountName =
        account != null ? account.name : AppLocalizations.of(context).translate('error');
    final settingsNotifier = Provider.of<SettingsNotifier>(context, listen: false);

    return RaisedButton(
      color: color,
      elevation: 3,
      onPressed: onPressed,
      highlightColor: categoryColor.withOpacity(0.2),
      splashColor: categoryColor.withOpacity(0.2),
      child: ListTile(
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
            color: ColorChooserFromTheme.transacColorTypeChooser(
              transac.type,
              settingsNotifier.getTheme(),
            ),
          ),
        ),
        subtitle: Text(accountName),
      ),
    );
  }
}
