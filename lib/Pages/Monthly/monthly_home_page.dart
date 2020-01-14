import 'package:expense_app/Components/Global/calendar_flat_button.dart';
import 'package:expense_app/Components/Global/my_bottom_nav_bar.dart';
import 'package:expense_app/Components/Global/my_drawer.dart';
import 'package:expense_app/Pages/Monthly/monthly_expenses_page.dart';
import 'package:expense_app/Pages/stats_page.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Providers/monthly_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyHomePage extends StatefulWidget {
  // final DateTime date;

  // MonthlyHomePage(this.date) {
  //   print('new monthly page instance');
  // }

  @override
  _MonthlyHomePageState createState() => _MonthlyHomePageState();
}

class _MonthlyHomePageState extends State<MonthlyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);
    final _monthlyModel = Provider.of<MonthlyModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_monthlyModel.getMonthlyTitle()),
        actions: <Widget>[
          CalendarFlatButton(
            onPressed: () =>
                _monthlyModel.openMonthlyTableCalendarPage(context),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _monthlyModel.pageIndex,
          children: <Widget>[
            MonthlyExpensesPage(),
            StatsPage(
              localModel: _monthlyModel,
              future: () => _expenseModel.dbHelper
                  .queryExpensesInMonth(_monthlyModel.yearMonth),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: _monthlyModel.pageIndex,
        onTap: (int index) {
          setState(() {
            _monthlyModel.pageIndex = index;
          });
        },
      ),
    );
  }
}
