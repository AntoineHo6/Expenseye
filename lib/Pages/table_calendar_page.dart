import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:expense_app/Utils/table_calendar_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarPage extends StatefulWidget {
  @override
  _TableCalendarPage createState() => _TableCalendarPage();
}

class _TableCalendarPage extends State<TableCalendarPage>
    with TickerProviderStateMixin {
  CalendarController _calendarController;

  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('John wick'),
      ),
      body: FutureBuilder<List<Expense>>(
        future: _expenseModel.dbHelper.queryAllExpenses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              Map<DateTime, List> _events = TableCalendarUtil.expensesToEvents(snapshot.data);

              return TableCalendar(
                calendarController: _calendarController,
                events: _events,
                initialSelectedDay: _expenseModel.dailyDate,
                onDaySelected: (date, list) => _changeDate(date, _expenseModel),
                builders: CalendarBuilders(
                  singleMarkerBuilder: (context, date, _) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 0.3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CategoryProperties.properties[_.category]
                            ['color'],
                      ),
                    );
                  },
                ),
              );
            } else {
              return Align(
                alignment: Alignment.center,
                child: Text(Strings.dataIsNull),
              );
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

  void _changeDate(DateTime date, ExpenseModel globalProvider) {
    globalProvider.dailyDate = date;
    print(date.toIso8601String());

    Navigator.pop(context);
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
