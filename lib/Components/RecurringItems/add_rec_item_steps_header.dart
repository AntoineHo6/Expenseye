import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AddRecItemStepsHeader extends StatelessWidget {
  final String title;
  final double percent;

  AddRecItemStepsHeader({@required this.title, @required this.percent});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(15),
          child: FittedBox(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 5),
          child: FittedBox(
            child: LinearPercentIndicator(
              width: 300.0,
              lineHeight: 14.0,
              percent: percent,
              linearStrokeCap: LinearStrokeCap.butt,
              backgroundColor: Colors.grey,
              progressColor: MyColors.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
