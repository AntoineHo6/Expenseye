import 'package:Expenseye/Components/Global/calendar_flat_button.dart';
import 'package:Expenseye/Components/Global/my_bottom_nav_bar.dart';
import 'package:Expenseye/Components/Global/my_drawer.dart';
import 'package:Expenseye/Pages/Monthly/monthly_expenses_page.dart';
import 'package:Expenseye/Pages/stats_page.dart';
import 'package:Expenseye/Providers/Global/expense_model.dart';
import 'package:Expenseye/Providers/monthly_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyHomePage extends StatefulWidget {
  final PageController pageController;

  MonthlyHomePage({this.pageController});

  @override
  _MonthlyHomePageState createState() => _MonthlyHomePageState();
}

class _MonthlyHomePageState extends State<MonthlyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context, listen: false);
    final _monthlyModel = Provider.of<MonthlyModel>(context, listen: false);
    
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
      drawer: MyDrawer(pageController: widget.pageController),
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
