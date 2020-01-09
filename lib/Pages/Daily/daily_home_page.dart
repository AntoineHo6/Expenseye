import 'package:expense_app/Components/my_drawer.dart';
import 'package:expense_app/Pages/Daily/daily_page.dart';
import 'package:expense_app/Pages/Daily/daily_stats_page.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';

class DailyHomePage extends StatefulWidget {
  @override
  _DailyHomePageState createState() => _DailyHomePageState();
}

class _DailyHomePageState extends State<DailyHomePage> {
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
            DailyPage(),
            DailyStatsPage(),
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
            icon: Icon(Icons.list, color: Colors.white,),
            title: Text(
              'Expenses',
              style: Theme.of(context).textTheme.body1,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart, color: Colors.white),
            title: Text(
              'Stats',
              style: Theme.of(context).textTheme.body1,
            ),
          )
        ],
      ),
    );
  }
}
