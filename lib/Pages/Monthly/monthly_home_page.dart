import 'package:expense_app/Components/my_drawer.dart';
import 'package:expense_app/Pages/Daily/daily_stats_page.dart';
import 'package:expense_app/Pages/Monthly/monthly_page.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';

class MonthlyHomePage extends StatefulWidget {
  @override
  _MonthlyHomePageState createState() => _MonthlyHomePageState();
}

class _MonthlyHomePageState extends State<MonthlyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black00dp,
      drawer: MyDrawer(),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            MonthlyPage(),
            DailyStatsPage(), // temp
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.black24dp,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.list, color: Colors.white,),
            title: Text(
              Strings.expenses,
              style: Theme.of(context).textTheme.body1,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart, color: Colors.white),
            title: Text(
              Strings.stats,
              style: Theme.of(context).textTheme.body1,
            ),
          )
        ],
      ),
    );
  }
}
