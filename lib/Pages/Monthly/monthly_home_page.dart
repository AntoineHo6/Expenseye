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
  final DateTime date;

  MonthlyHomePage(this.date);

  @override
  _MonthlyHomePageState createState() => _MonthlyHomePageState();
}

class _MonthlyHomePageState extends State<MonthlyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);

    return ChangeNotifierProvider(
      create: (_) => MonthlyModel(widget.date),
      child: Consumer<MonthlyModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(model.getMonthlyTitle()),
            actions: <Widget>[
              CalendarFlatButton(
                onPressed: () => model.openMonthlyTableCalendarPage(context),
              ),
            ],
          ),
          drawer: MyDrawer(),
          body: SafeArea(
            top: false,
            child: IndexedStack(
              index: _currentIndex,
              children: <Widget>[
                MonthlyExpensesPage(),
                StatsPage(
                  localModel: model,
                  future: () => _expenseModel.dbHelper
                      .queryExpensesInMonth(model.yearMonth),
                ),
              ],
            ),
          ),
          bottomNavigationBar: MyBottomNavBar(
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
