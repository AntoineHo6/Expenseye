import 'package:expense_app/Components/Global/my_table_calendar.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:expense_app/Utils/table_calendar_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthlyTableCalendarPage extends StatefulWidget {
  final initialDate;

  MonthlyTableCalendarPage(this.initialDate);

  @override
  _MonthlyTableCalendarPage createState() => _MonthlyTableCalendarPage();
}

class _MonthlyTableCalendarPage extends State<MonthlyTableCalendarPage>
    with TickerProviderStateMixin {
  CalendarController _calendarController;

  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context, listen: false);

    return Scaffold(
      backgroundColor: MyColors.black00dp,
      appBar: AppBar(
        title: Text(Strings.pickAMonth),
      ),
      body: FutureBuilder<List<Expense>>(
        future: _expenseModel.dbHelper.queryAllExpenses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              Map<DateTime, List> _events =
                  TableCalendarUtil.expensesToEvents(snapshot.data);
              return Column(
                children: <Widget>[
                  MyTableCalendar(
                    initialDate: widget.initialDate,
                    events: _events,
                    calendarController: _calendarController,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  RaisedButton(
                    color: MyColors.black02dp,
                    textTheme: ButtonTextTheme.primary,
                    child: Text(Strings.chooseMonthCaps),
                    onPressed: _quit,
                  ),
                ],
              );
            } else {
              return Container();
            }
          } else {
            return Align(
              alignment: Alignment.center,
              child: new CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _quit() {
    Navigator.pop(
        context, DateTimeUtil.timeToZeroInDate(_calendarController.focusedDay));
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }
}
