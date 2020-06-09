import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';

class DatePickerBtn extends StatelessWidget {
  final DateTime date;
  final Function onPressed;
  final double minWidth;
  final double height;
  final double iconSize;
  final double spaceBetweenSize;
  final double fontSize;
  final double borderRadiusSize;

  DatePickerBtn({
    @required this.date,
    @required this.onPressed,
    this.minWidth = 100,
    this.height = 50,
    this.iconSize = 20,
    this.fontSize = 15,
    this.spaceBetweenSize = 8,
    this.borderRadiusSize = 5,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: minWidth,
      height: height,
      buttonColor: Theme.of(context).buttonColor,
      textTheme: ButtonTextTheme.primary,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusSize),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.date_range,
              size: iconSize,
            ),
            SizedBox(
              width: spaceBetweenSize,
            ),
            Text(
              DateTimeUtil.formattedDate(context, date),
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}
