import 'package:Expenseye/Resources/Themes/MyColors.dart';
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
        weekendStyle: TextStyle(color: MyColors.secondary),
      ),
      headerStyle: HeaderStyle(
        leftChevronIcon: const Icon(Icons.chevron_left),
        rightChevronIcon: const Icon(Icons.chevron_right),
        formatButtonVisible: false,
      ),
      calendarStyle: CalendarStyle(
        todayColor: MyColors.black01dp,
        selectedColor: MyColors.black24dp,
        weekendStyle: TextStyle(color: MyColors.secondaryDarker),
        outsideWeekendStyle: TextStyle(color: MyColors.secondaryDisabled),
      ),
      calendarController: calendarController,
      initialSelectedDay: initialDate,
      onDaySelected: onDaySelected,
      availableGestures: AvailableGestures.horizontalSwipe,
    );
  }
}
