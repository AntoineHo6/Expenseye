import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Providers/Global/settings_notifier.dart';
import 'package:Expenseye/Resources/Themes/app_colors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyYearlyHeader extends StatelessWidget {
  final pageModel; // MonthlyModel or YearlyModel

  MonthlyYearlyHeader({this.pageModel});

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
                TransacType.income,
              ),
              const SizedBox(width: 5),
              _headerItemTypeTotalRect(
                context,
                AppLocalizations.of(context).translate('expense'),
                pageModel.currentExpenseTotal,
                TransacType.expense,
              ),
              const SizedBox(width: 5),
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
    TransacType type,
  ) {
    final settingsNotifier =
        Provider.of<SettingsNotifier>(context, listen: false);
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              FittedBox(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              const SizedBox(height: 5),
              FittedBox(
                child: Text(
                  type == TransacType.expense
                      ? '- ${total.toStringAsFixed(2)} \$'
                      : '+ ${total.toStringAsFixed(2)} \$',
                  style: TextStyle(
                    color: ColorChooserFromTheme.itemColorTypeChooser(
                      type,
                      settingsNotifier.getTheme(),
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
    final settingsNotifier =
        Provider.of<SettingsNotifier>(context, listen: false);
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              FittedBox(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              const SizedBox(height: 5),
              FittedBox(
                child: Text(
                  '${total.toStringAsFixed(2)} \$',
                  style: TextStyle(
                    color: ColorChooserFromTheme.balanceColorChooser(
                      settingsNotifier.getTheme(),
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
