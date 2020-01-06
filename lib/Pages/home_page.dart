import 'package:expense_app/Components/my_drawer.dart';
import 'package:expense_app/Pages/daily_page.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.periwinkle,
      // appBar: AppBar(
      //   title: Text(Strings.daily),
      // ),
      drawer: MyDrawer(),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            DailyPage(),
            Text('John Wick'),  // temp. should be stats page
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
