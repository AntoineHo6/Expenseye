import 'package:Expenseye/Components/Global/calendar_flat_button.dart';
import 'package:Expenseye/Components/Global/my_bottom_nav_bar.dart';
import 'package:Expenseye/Components/Global/my_drawer.dart';
import 'package:Expenseye/Pages/Daily/daily_expenses_page.dart';
import 'package:Expenseye/Pages/stats_page.dart';
import 'package:Expenseye/Providers/Global/expense_model.dart';
import 'package:Expenseye/Providers/daily_model.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyHomePage extends StatefulWidget {
  final PageController pageController;

  DailyHomePage({this.pageController});

  @override
  _DailyHomePageState createState() => _DailyHomePageState();
}

class _DailyHomePageState extends State<DailyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context, listen: false);
    final _dailyModel = Provider.of<DailyModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(DateTimeUtil.formattedDate(_dailyModel.currentDate)),
        actions: <Widget>[
          CalendarFlatButton(
            onPressed: () => _dailyModel.openDailyTableCalendarPage(context),
          ),
        ],
      ),
      drawer: MyDrawer(pageController: widget.pageController,),
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
