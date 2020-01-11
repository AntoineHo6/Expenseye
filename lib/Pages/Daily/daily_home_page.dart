import 'package:expense_app/Components/Global/my_drawer.dart';
import 'package:expense_app/Pages/Daily/daily_expenses_page.dart';
import 'package:expense_app/Pages/Daily/daily_stats_page.dart';
import 'package:expense_app/Providers/daily_model.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
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
    return ChangeNotifierProvider(
      create: (_) => DailyModel(),
      child: Consumer<DailyModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: MyColors.black00dp,
          drawer: const MyDrawer(),
          body: SafeArea(
            top: false,
            child: IndexedStack(
              index: _currentIndex,
              children: <Widget>[
                DailyExpensesPage(),
                DailyStatsPage(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedIconTheme: IconThemeData(color: MyColors.secondary),
            backgroundColor: MyColors.black24dp,
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.list),
                title: Text(
                  Strings.expenses,
                  style: Theme.of(context).textTheme.body1,
                ),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.pie_chart),
                title: Text(
                  Strings.stats,
                  style: Theme.of(context).textTheme.body1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
