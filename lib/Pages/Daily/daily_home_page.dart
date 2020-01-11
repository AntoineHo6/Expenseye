import 'package:expense_app/Components/Global/calendar_flat_button.dart';
import 'package:expense_app/Components/Global/my_bottom_nav_bar.dart';
import 'package:expense_app/Components/Global/my_drawer.dart';
import 'package:expense_app/Pages/Daily/daily_expenses_page.dart';
import 'package:expense_app/Pages/stats_page.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Providers/daily_model.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyHomePage extends StatefulWidget {
  @override
  _DailyHomePageState createState() => _DailyHomePageState();
}

class _DailyHomePageState extends State<DailyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);

    return ChangeNotifierProvider(
      create: (_) => DailyModel(),
      child: Consumer<DailyModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(DateTimeUtil.formattedDate(model.currentDate)),
            actions: <Widget>[
              CalendarFlatButton(
                onPressed: () => model.openDailyTableCalendarPage(context),
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
                DailyExpensesPage(),
                StatsPage(
                  localModel: model,
                  future: () => _expenseModel.dbHelper
                      .queryExpensesInDate(model.currentDate),
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
