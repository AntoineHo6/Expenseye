import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MyTableCalendar extends StatelessWidget {
  final DateTime initialDate;
  final CalendarController calendarController;
  final onDaySelected;

  MyTableCalendar({
    @required this.initialDate,
    @required this.calendarController,
    this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: AppLocalizations.of(context).locale.languageCode,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle(color: Theme.of(context).indicatorColor),
      ),
      headerStyle: HeaderStyle(
        leftChevronIcon: const Icon(Icons.chevron_left),
        rightChevronIcon: const Icon(Icons.chevron_right),
        formatButtonVisible: false,
      ),
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        todayColor: Theme.of(context).hintColor,
        selectedColor: Theme.of(context).accentColor,
        weekendStyle: TextStyle(color: Theme.of(context).accentColor),
      ),
      calendarController: calendarController,
      initialSelectedDay: initialDate,
      onDaySelected: onDaySelected,
      availableGestures: AvailableGestures.horizontalSwipe,
    );
  }
}
