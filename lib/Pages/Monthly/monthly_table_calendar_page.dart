import 'package:Expenseye/Components/Global/my_table_calendar.dart';
import 'package:Expenseye/Models/Expense.dart';
import 'package:Expenseye/Providers/Global/expense_income_model.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/Utils/table_calendar_util.dart';
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
    final _expenseModel = Provider.of<ExpenseIncomeModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.pickAMonth),
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
                  const SizedBox(
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
              child: const CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _quit() {
    Navigator.pop(context, _calendarController.focusedDay);
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
