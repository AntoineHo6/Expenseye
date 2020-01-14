import 'package:expense_app/Pages/Monthly/monthly_home_page.dart';
import 'package:expense_app/Pages/Yearly/yearly_home_page.dart';
import 'package:flutter/material.dart';

import 'Daily/daily_home_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController(
    initialPage: 0,
    keepPage: true,
  );

  // have to put all models here to not lose the current state of each page

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: <Widget>[
        DailyHomePage(),
        MonthlyHomePage(DateTime.now()),
        YearlyHomePage()
      ],
    );
  }
}
