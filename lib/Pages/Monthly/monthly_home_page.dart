import 'package:Expenseye/Components/Global/my_bottom_nav_bar.dart';
import 'package:Expenseye/Pages/Monthly/monthly_items_page.dart';
import 'package:Expenseye/Pages/stats_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/monthly_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyHomePage extends StatefulWidget {
  @override
  _MonthlyHomePageState createState() => _MonthlyHomePageState();
}

class _MonthlyHomePageState extends State<MonthlyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _monthlyModel = Provider.of<MonthlyModel>(context, listen: false);
    final _dbModel = Provider.of<DbModel>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _monthlyModel.pageIndex,
          children: <Widget>[
            MonthlyItemsPage(),
            StatsPage(
              localModel: _monthlyModel,
              future: () => _dbModel.dbHelper
                  .queryItemsInMonth(_monthlyModel.yearMonth),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: _monthlyModel.pageIndex,
        onTap: (int index) {
          setState(() {
            _monthlyModel.pageIndex = index;
          });
        },
      ),
    );
  }
}
