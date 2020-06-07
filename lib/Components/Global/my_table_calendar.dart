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
      headerStyle: HeaderStyle(
        leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white),
        rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.white),
        formatButtonVisible: false,
      ),
      calendarStyle: CalendarStyle(
        todayColor: MyColors.black01dp,
        selectedColor: MyColors.black24dp,
      ),
      calendarController: calendarController,
      initialSelectedDay: initialDate,
      onDaySelected: onDaySelected,
    );
  }
}
