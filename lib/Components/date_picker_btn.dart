import 'package:expense_app_beginner/ChangeNotifiers/edit_add_expense_model.dart';
import 'package:flutter/material.dart';

class DatePickerBtn extends StatelessWidget {
  final EditAddExpenseModel model;

  DatePickerBtn(this.model);

  @override
  Widget build(BuildContext context) {
    final DateTime _date = model.date;

    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 4.0,
      onPressed: () async {
        model.date = await showDatePicker(
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

        model.infoChanged(null);
      },
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.date_range,
                        size: 18.0,
                        color: Colors.teal,
                      ),
                      Text(
                        model.date != null
                            ? '${_date.year} - ${_date.month} - ${_date.day}'
                            : 'empty',
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Text(
              "  Change",
              style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ],
        ),
      ),
      color: Colors.white,
    );
  }
}
