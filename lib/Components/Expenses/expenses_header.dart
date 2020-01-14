import 'package:Expenseye/Components/Global/calendar_flat_button.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';

class ExpensesHeader extends StatelessWidget {
  final String total;
  final pageModel;  // DailyModel, MonthlyModel or YearlyModel

  ExpensesHeader({this.total, this.pageModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CalendarFlatButton(
            onPressed: () => pageModel.calendarFunc(context),
          ),
          Text(
            pageModel.getTitle(),
            style: Theme.of(context).textTheme.headline,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              '${Strings.total}: $total',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ],
      ),
    );
  }
}
