import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Providers/Global/theme_notifier.dart';
import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemsHeader extends StatelessWidget {
  final pageModel; // DailyModel, MonthlyModel or YearlyModel

  ItemsHeader({this.pageModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FittedBox(
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Text(
                pageModel.getTitle(context),
                style: TextStyle(fontSize: 55, fontWeight: FontWeight.w100),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _headerItemTypeTotalRect(
                context,
                AppLocalizations.of(context).translate('income'),
                pageModel.currentIncomeTotal,
                ItemType.income,
              ),
              const SizedBox(width: 10),
              _headerItemTypeTotalRect(
                context,
                AppLocalizations.of(context).translate('expense'),
                pageModel.currentExpenseTotal,
                ItemType.expense,
              ),
              const SizedBox(width: 10),
              _headerBalanceTotalRectangle(
                context,
                AppLocalizations.of(context).translate('balance'),
                pageModel.currentTotal,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerItemTypeTotalRect(
    BuildContext context,
    String title,
    double total,
    ItemType type,
  ) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: 5),
              FittedBox(
                child: Text(
                  type == ItemType.expense
                      ? '- ${total.toStringAsFixed(2)} \$'
                      : '+ ${total.toStringAsFixed(2)} \$',
                  style: TextStyle(
                    color: ColorChooserFromTheme.itemColorTypeChooser(
                      type,
                      themeNotifier.getTheme(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerBalanceTotalRectangle(
    BuildContext context,
    String title,
    double total,
  ) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: 5),
              FittedBox(
                child: Text(
                  '${total.toStringAsFixed(2)} \$',
                  style: TextStyle(
                    color: ColorChooserFromTheme.balanceColorChooser(
                      themeNotifier.getTheme(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
