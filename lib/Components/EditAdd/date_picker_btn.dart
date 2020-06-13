import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';

class DatePickerBtn extends StatelessWidget {
  final DateTime date;
  final Function onPressed;
  final double width;
  final double height;
  final double iconSize;
  final double spaceBetweenSize;
  final double fontSize;

  DatePickerBtn({
    @required this.date,
    @required this.onPressed,
    this.width = 100,
    this.height = 50,
    this.iconSize = 20,
    this.fontSize = 15,
    this.spaceBetweenSize = 8,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: RaisedButton(        
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
