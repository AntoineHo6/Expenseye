import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MyTableCalendar extends StatelessWidget {
  final Map<DateTime, List<dynamic>> events;
  final DateTime initialDate;
  final CalendarController calendarController;
  final onDaySelected;

  MyTableCalendar(
      {@required this.initialDate,
      @required this.calendarController,
      this.events,
      this.onDaySelected});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      headerStyle: HeaderStyle(
        leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white),
        rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.white),
        formatButtonVisible: false,
      ),
      calendarStyle: CalendarStyle(
        todayColor: MyColors.black01dp,
        selectedColor: MyColors.black24dp,
        markersColor: Colors.white,
      ),
      calendarController: calendarController,
      events: events,
      initialSelectedDay: initialDate,
      onDaySelected: onDaySelected,
      builders: CalendarBuilders(
        singleMarkerBuilder: (context, date, expense) {
          return Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 0.3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CategoryProperties.properties[expense.category]['color'],
            ),
          );
        },
      ),
    );
  }
}
