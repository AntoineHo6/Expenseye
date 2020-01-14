import 'package:Expenseye/Components/Global/calendar_flat_button.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';

class ExpensesHeader extends StatelessWidget {
  final String total;
  final pageModel;

  ExpensesHeader({this.total, this.pageModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              pageModel.getTitle(),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                '${Strings.total}: $total',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            CalendarFlatButton(
              onPressed: () => pageModel.calendarFunc(context),
            ),
          ],
        ),
      ],
    );
  }
}
