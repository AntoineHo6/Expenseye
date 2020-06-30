import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/settings_notifier.dart';
import 'package:Expenseye/Resources/Themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransacListTile extends StatelessWidget {
  final Transac transac;
  final EdgeInsets contentPadding;
  final Function onPressed;
  final Color color;

  TransacListTile(this.transac, {this.contentPadding, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    Color categoryColor = DbModel.catMap[transac.categoryId].color;
    IconData iconData = DbModel.catMap[transac.categoryId].iconData;
    final settingsNotifier = Provider.of<SettingsNotifier>(context, listen: false);

    print(DbModel.accMap[transac.id].name);

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
              ? '- ${transac.amount.toStringAsFixed(2)} \$'
              : '+ ${transac.amount.toStringAsFixed(2)} \$',
          style: TextStyle(
            color: ColorChooserFromTheme.transacColorTypeChooser(
              transac.type,
              settingsNotifier.getTheme(),
            ),
          ),
        ),
        // subtitle: Text(DbModel.accMap[transac.id].name), // TODO: change to the name
      ),
    );
  }
}
