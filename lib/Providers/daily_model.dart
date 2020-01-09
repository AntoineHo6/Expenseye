import 'package:expense_app/Components/AlertDialogs/add_expense_dialog.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Pages/edit_expense_page.dart';
import 'package:expense_app/Pages/table_calendar_page.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:flutter/material.dart';

class DailyModel extends ChangeNotifier {
  // don't include todays time for uniform data
  DateTime currentDate = DateTimeUtil.timeToZeroInDate(DateTime.now());


  void showAddExpense(BuildContext context) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => AddExpenseDialog(currentDate),
    );

    if (confirmed) {
      final snackBar = SnackBar(
        content: Text(Strings.succAdded),
        backgroundColor: Colors.grey.withOpacity(0.5),
      );

      Scaffold.of(context).showSnackBar(snackBar);
    }
  }


  void openEditExpense(BuildContext context, Expense expense) async {
    int action = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditExpensePage(expense)),
    );

    if (action != null) {
      final snackBar = SnackBar(
        content:
            action == 1 ? Text(Strings.succEdited) : Text(Strings.succDeleted),
        backgroundColor: Colors.grey.withOpacity(0.5),
      );

      Scaffold.of(context).showSnackBar(snackBar);
    }
  }


  void openTableCalendarPage(BuildContext context) async {
    DateTime newDate = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TableCalendarPage(currentDate)),
    );

    if (newDate != null) {
      currentDate = newDate;
      notifyListeners();
    }
  }
}