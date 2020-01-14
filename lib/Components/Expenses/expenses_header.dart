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
        Container(
          padding: const EdgeInsets.only(top: 15, left: 20),
          child: Row(
            children: <Widget>[
              Text(
                pageModel.getTitle(),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline,
              ),
              CalendarFlatButton(
                onPressed: () => pageModel.calendarFunc(context),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Text(
              '${Strings.total}: $total',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
      ],
    );
  }
}
