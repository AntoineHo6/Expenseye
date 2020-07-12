import 'package:Expenseye/Resources/Themes/app_colors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:Expenseye/Components/Global/future_total_box.dart';

class MonthlyYearlyHeader extends StatelessWidget {
  final String title;
  final Future<double> incomesTotalFuture;
  final Future<double> expensesTotalFuture;
  final Future<double> balanceTotalFuture;

  MonthlyYearlyHeader({
    this.title,
    this.incomesTotalFuture,
    this.expensesTotalFuture,
    this.balanceTotalFuture,
  });

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
                title,
                style: TextStyle(fontSize: 55, fontWeight: FontWeight.w100),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureTotalBox(
                title: AppLocalizations.of(context).translate('income'),
                textColor: ColorChooserFromTheme.expenseColor,
                future: incomesTotalFuture,
              ),
              FutureTotalBox(
                title: AppLocalizations.of(context).translate('expense'),
                textColor: ColorChooserFromTheme.incomeColor,
                future: expensesTotalFuture,
              ),
              FutureTotalBox(
                title: AppLocalizations.of(context).translate('balance'),
                textColor: ColorChooserFromTheme.balanceColor,
                future: balanceTotalFuture,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
