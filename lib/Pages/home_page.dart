import 'package:Expenseye/Components/Global/my_drawer.dart';
import 'package:Expenseye/Pages/Monthly/monthly_home_page.dart';
import 'package:Expenseye/Pages/Yearly/yearly_home_page.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/google_firebase_helper.dart';
import 'package:flutter/material.dart';

import 'Daily/daily_home_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 1,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      GoogleFirebaseHelper.uploadDbFile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
        actions: <Widget>[],
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: const Text(Strings.daily),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: const Text(Strings.monthly),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: const Text(Strings.yearly),
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          DailyHomePage(),
          MonthlyHomePage(),
          YearlyHomePage(goToMonthPage: goToMonthPage),
        ],
      ),
    );
  }

  void goToMonthPage() {
    _tabController.animateTo(1);
  }
}
