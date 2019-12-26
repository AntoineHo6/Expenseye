import 'package:expense_app_beginner/ChangeNotifiers/edit_add_expense_model.dart';
import 'package:flutter/material.dart';

class DatePickerBtn extends StatelessWidget {
  final EditAddExpenseModel model;

  DatePickerBtn(this.model);

  @override
  Widget build(BuildContext context) {
    final DateTime _date = model.date;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: RaisedButton(
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
            Text(
              '${_date.year} - ${_date.month} - ${_date.day}',
              style: TextStyle(
                  //color: Colors.teal,
                  //fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ],
        ),
        color: Colors.white,
      ),
    );
  }
}
