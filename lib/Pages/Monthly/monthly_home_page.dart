import 'package:expense_app/Components/my_drawer.dart';
import 'package:expense_app/Pages/Monthly/monthly_page.dart';
import 'package:expense_app/Providers/monthly_model.dart';
import 'package:expense_app/Resources/Strings.dart';
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
          backgroundColor: MyColors.black00dp,
          drawer: MyDrawer(),
          body: SafeArea(
            top: false,
            child: IndexedStack(
              index: _currentIndex,
              children: <Widget>[
                MonthlyPage(),
                Text('wanli'), // TODO: change
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
                icon: Icon(Icons.pie_chart),
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
