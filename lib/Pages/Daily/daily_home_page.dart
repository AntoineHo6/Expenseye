import 'package:Expenseye/Components/Global/my_bottom_nav_bar.dart';
import 'package:Expenseye/Pages/Daily/daily_expenses_page.dart';
import 'package:Expenseye/Pages/stats_page.dart';
import 'package:Expenseye/Providers/Global/expense_model.dart';
import 'package:Expenseye/Providers/daily_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyHomePage extends StatefulWidget {
  @override
  _DailyHomePageState createState() => _DailyHomePageState();
}

class _DailyHomePageState extends State<DailyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context, listen: false);
    final _dailyModel = Provider.of<DailyModel>(context, listen: false);

    return Scaffold(
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
