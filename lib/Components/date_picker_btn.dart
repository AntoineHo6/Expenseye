import 'package:expense_app_beginner/ChangeNotifiers/Global/expense_model.dart';
import 'package:expense_app_beginner/ChangeNotifiers/edit_add_expense_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatePickerBtn extends StatelessWidget {
  final EditAddExpenseModel model;

  DatePickerBtn(this.model);

  @override
  Widget build(BuildContext context) {
    final DateTime _date = model.date;
    final _expenseModel = Provider.of<ExpenseModel>(context);

    return Container(
      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
      child: RaisedButton(
        color: Colors.blueAccent,
        textColor: Colors.white,
        padding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 3.0,
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
            Text(_expenseModel.dateToString(_date)),
          ],
        ),
      ),
    );
  }
}
