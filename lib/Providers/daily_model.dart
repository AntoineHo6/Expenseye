import 'package:Expenseye/Pages/Daily/daily_table_calendar_page.dart';
import 'package:Expenseye/Providers/home_page_model.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyModel extends ChangeNotifier {
  DateTime currentDate = DateTime.now();
  double currentTotal = 0;
  int pageIndex = 0;

  void openDailyTableCalendarPage(BuildContext context) async {
    DateTime newDate = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DailyTableCalendarPage(currentDate),
      ),
    );

    // TODO: make this into a seperate function
    if (newDate != null) {
      currentDate = newDate;
      Provider.of<HomePageModel>(context, listen: false).updateAppBar(
        newAppBarTitle: DateTimeUtil.formattedDate(currentDate)
      );
      //notifyListeners();
    }
  }
}
