import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Providers/edit_add_expense_model.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatePickerBtn extends StatelessWidget {
  final DateTime date;
  final Function func;

  DatePickerBtn(this.date, this.func);

  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);
    final _editAddExpenseModel = Provider.of<EditAddExpenseModel>(context);

    return RaisedButton(
      color: MyColors.black02dp,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 3.0,
      onPressed: () => chooseDate(context, date, _editAddExpenseModel),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.date_range,
              size: 18.0,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              _expenseModel.formattedDate(date),
            ),
          ],
        ),
      ),
    );
  }

  void chooseDate(BuildContext context, DateTime initialDate,
      EditAddExpenseModel _editAddExpenseModel) async {
    DateTime newDate;

    await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    ).then((value) {
      newDate = value;
    });

    _editAddExpenseModel.updateDate(newDate);
  }
}

// TODO: dont put the EditAddExpenseModel in here. Fucks shit up if context
// TODO: doesn't have it.
