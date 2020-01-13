import 'package:expense_app/Components/Global/my_table_calendar.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:expense_app/Utils/table_calendar_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DailyTableCalendarPage extends StatefulWidget {
  final initialDate;

  DailyTableCalendarPage(this.initialDate);

  @override
  _DailyTableCalendarPage createState() => _DailyTableCalendarPage();
}

class _DailyTableCalendarPage extends State<DailyTableCalendarPage>
    with TickerProviderStateMixin {
  CalendarController _calendarController;

  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.pickADate),
      ),
      body: FutureBuilder<List<Expense>>(
        future: _expenseModel.dbHelper.queryAllExpenses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              Map<DateTime, List> _events =
                  TableCalendarUtil.expensesToEvents(snapshot.data);
              return MyTableCalendar(
                initialDate: widget.initialDate,
                events: _events,
                calendarController: _calendarController,
                onDaySelected: (date, list) => _quit(date),
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

  void _quit(DateTime date) {
    Navigator.pop(context, DateTimeUtil.timeToZeroInDate(date));
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
