import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:flutter/material.dart';

class DatePickerBtn extends StatelessWidget {
  final DateTime date;
  final Function function;

  DatePickerBtn(this.date, this.function);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: MyColors.black02dp,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 3.0,
      onPressed: function,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.date_range,
              size: 18.0,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              DateTimeUtil.formattedDate(date),
            ),
          ],
        ),
      ),
    );
  }
}
