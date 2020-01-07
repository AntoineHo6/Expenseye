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
      backgroundColor: MyColors.periwinkle,
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
        backgroundColor: Colors.white70,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.list),
            title: new Text('Expenses'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            title: Text('Stats'),
          )
        ],
      ),
    );
  }
}
