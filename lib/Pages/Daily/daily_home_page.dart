import 'package:expense_app/Components/Global/calendar_flat_button.dart';
import 'package:expense_app/Components/Global/my_bottom_nav_bar.dart';
import 'package:expense_app/Components/Global/my_drawer.dart';
import 'package:expense_app/Pages/Daily/daily_expenses_page.dart';
import 'package:expense_app/Pages/stats_page.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Providers/daily_model.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyHomePage extends StatefulWidget {
  @override
  _DailyHomePageState createState() => _DailyHomePageState();
}

class _DailyHomePageState extends State<DailyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);
    final _dailyModel = Provider.of<DailyModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(DateTimeUtil.formattedDate(_dailyModel.currentDate)),
        actions: <Widget>[
          CalendarFlatButton(
            onPressed: () => _dailyModel.openDailyTableCalendarPage(context),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _dailyModel.pageIndex,
          children: <Widget>[
            DailyExpensesPage(),
            StatsPage(
              localModel: _dailyModel,
              future: () => _expenseModel.dbHelper
                  .queryExpensesInDate(_dailyModel.currentDate),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: _dailyModel.pageIndex,
        onTap: (int index) {
          setState(() {
            _dailyModel.pageIndex = index;
          });
        },
      ),
    );
  }
}
