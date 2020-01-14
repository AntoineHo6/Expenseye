import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';

class HomePageModel extends ChangeNotifier {
  String appBarTitle = DateTimeUtil.formattedDate(DateTime.now());
  Function appBarCalendarFunc;

  void updateAppBar({String newAppBarTitle, Function newAppBarCalendarFunc}) {
    appBarTitle = newAppBarTitle;

    if (newAppBarCalendarFunc != null)
      appBarCalendarFunc = newAppBarCalendarFunc;
      
    notifyListeners();
  }
}
