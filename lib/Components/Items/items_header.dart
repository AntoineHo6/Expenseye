import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

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
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Text(
              pageModel.getTitle(context),
              style: TextStyle(fontSize: 55, fontWeight: FontWeight.w100),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.incomeBGColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(
                            AppLocalizations.of(context).translate('income')),
                        const SizedBox(height: 5),
                        Text(
                          '${pageModel.currentIncomeTotal.toStringAsFixed(2)} \$',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.expenseBGColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(AppLocalizations.of(context)
                            .translate('expense')),
                        const SizedBox(height: 5),
                        Text(
                          '${pageModel.currentExpenseTotal.toStringAsFixed(2)} \$',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.balanceColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(AppLocalizations.of(context)
                            .translate('balance')),
                        const SizedBox(height: 5),
                        Text(
                          '${pageModel.currentTotal.toStringAsFixed(2)} \$',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
