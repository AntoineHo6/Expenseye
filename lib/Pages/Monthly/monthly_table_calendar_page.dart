import 'package:Expenseye/Components/Global/my_table_calendar.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthlyTableCalendarPage extends StatefulWidget {
  final initialDate;

  MonthlyTableCalendarPage(this.initialDate);

  @override
  _MonthlyTableCalendarPageState createState() =>
      _MonthlyTableCalendarPageState();
}

class _MonthlyTableCalendarPageState extends State<MonthlyTableCalendarPage>
    with TickerProviderStateMixin {
  CalendarController _calendarController;

  @override
  Widget build(BuildContext context) {
    final _dbModel = Provider.of<DbModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('pickAMonth')),
      ),
      body: FutureBuilder<List<Item>>(
        future: _dbModel.queryAllItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return Column(
                children: <Widget>[
                  MyTableCalendar(
                    initialDate: widget.initialDate,
                    calendarController: _calendarController,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  RaisedButton(
                    color: MyColors.black02dp,
                    textTheme: ButtonTextTheme.primary,
                    child: Text(
                      AppLocalizations.of(context).translate('selectMonthCaps'),
                    ),
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
