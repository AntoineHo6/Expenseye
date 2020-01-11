import 'package:expense_app/Components/Global/calendar_flat_button.dart';
import 'package:expense_app/Components/Global/my_bottom_nav_bar.dart';
import 'package:expense_app/Components/Global/my_drawer.dart';
import 'package:expense_app/Pages/Monthly/monthly_expenses_page.dart';
import 'package:expense_app/Pages/Monthly/monthly_stats_page.dart';
import 'package:expense_app/Providers/monthly_model.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyHomePage extends StatefulWidget {
  @override
  _MonthlyHomePageState createState() => _MonthlyHomePageState();
}

class _MonthlyHomePageState extends State<MonthlyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MonthlyModel(),
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
          backgroundColor: MyColors.black00dp,
          drawer: const MyDrawer(),
          body: SafeArea(
            top: false,
            child: IndexedStack(
              index: _currentIndex,
              children: <Widget>[
                MonthlyExpensesPage(),
                MonthlyStatsPage(),
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
