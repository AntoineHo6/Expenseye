import 'package:Expenseye/Resources/Themes/app_colors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:Expenseye/Components/Global/total_box.dart';

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
              TotalBox(
                title: AppLocalizations.of(context).translate('income'),
                total: '+${pageModel.currentIncomeTotal.toStringAsFixed(2)} \$',
                textColor: ColorChooserFromTheme.incomeColor,
              ),
              const SizedBox(width: 5),
              TotalBox(
                title: AppLocalizations.of(context).translate('expense'),
                total: '-${pageModel.currentExpenseTotal.toStringAsFixed(2)} \$',
                textColor: ColorChooserFromTheme.expenseColor,
              ),
              const SizedBox(width: 5),
              TotalBox(
                title: AppLocalizations.of(context).translate('balance'),
                total: '${pageModel.currentTotal.toStringAsFixed(2)} \$',
                textColor: ColorChooserFromTheme.balanceColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
