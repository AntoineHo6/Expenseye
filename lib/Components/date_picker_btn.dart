import 'package:expense_app_beginner/Providers/Global/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatePickerBtn extends RaisedButton {
  final DateTime date;
  final Function datePicker;

  const DatePickerBtn(this.date, this.datePicker);

  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);

    return RaisedButton(
      color: Colors.blueAccent,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 4.0,
      onPressed: datePicker,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.date_range,
            size: 18.0,
          ),
          SizedBox(width: 10,),
          Text(_expenseModel.formattedDate(date)),
        ],
      ),
    );
  }
}
