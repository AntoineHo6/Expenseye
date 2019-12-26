import 'package:expense_app_beginner/ChangeNotifiers/Global/expense_model.dart';
import 'package:expense_app_beginner/ChangeNotifiers/edit_add_expense_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatePickerBtn extends RaisedButton {
  final EditAddExpenseModel model;

  const DatePickerBtn(this.model);

  @override
  Widget build(BuildContext context) {
    final DateTime _date = model.date;
    final _expenseModel = Provider.of<ExpenseModel>(context);

    return RaisedButton(
      color: Colors.blueAccent,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 4.0,
      onPressed: () async {
        DateTime datePicked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
          builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.light(),
              child: child,
            );
          },
        );

        model.updateDate(datePicked);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.date_range,
            size: 18.0,
            //color: Colors.teal,
          ),
          SizedBox(width: 10,),
          Text(_expenseModel.dateToString(_date)),
        ],
      ),
    );
  }
}
