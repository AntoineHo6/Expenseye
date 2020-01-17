import 'package:Expenseye/Components/Global/calendar_flat_button.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';

class ItemsHeader extends StatelessWidget {
  final pageModel; // DailyModel, MonthlyModel or YearlyModel

  ItemsHeader({this.pageModel});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  pageModel.getTitle(),
                  style: Theme.of(context).textTheme.display2,
                ),
                const SizedBox(width: 15),
                CalendarFlatButton(
                  onPressed: () => pageModel.calendarFunc(context),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Text(Strings.income),
                      Text(
                        '${pageModel.currentIncomeTotal.toStringAsFixed(2)} \$',
                        style: Theme.of(context).textTheme.headline,
                      ),
                    ],
                  ),
                  const SizedBox(width: 25),
                  Column(
                    children: <Widget>[
                      const Text(Strings.expense),
                      Text(
                        '${pageModel.currentExpenseTotal.toStringAsFixed(2)} \$',
                        style: Theme.of(context).textTheme.headline,
                      ),
                    ],
                  ),
                  const SizedBox(width: 25),
                  Column(
                    children: <Widget>[
                      const Text(Strings.balance),
                      Text(
                        '${pageModel.currentTotal.toStringAsFixed(2)} \$',
                        style: Theme.of(context).textTheme.headline,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
