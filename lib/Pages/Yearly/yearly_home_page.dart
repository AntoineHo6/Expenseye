import 'package:Expenseye/Components/Global/my_bottom_nav_bar.dart';
import 'package:Expenseye/Pages/Yearly/yearly_items_page.dart';
import 'package:Expenseye/Pages/stats_page.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Providers/yearly_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearlyHomePage extends StatefulWidget {
  final Function goToMonthPage;

  YearlyHomePage({this.goToMonthPage});

  @override
  _YearlyHomePageState createState() => _YearlyHomePageState();
}

class _YearlyHomePageState extends State<YearlyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ItemModel>(context, listen: false);
    final _yearlyModel = Provider.of<YearlyModel>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _yearlyModel.pageIndex,
          children: <Widget>[
            YearlyItemsPage(goToMonthPage: widget.goToMonthPage),
            StatsPage(
              localModel: _yearlyModel,
              future: () =>
                  _expenseModel.dbHelper.queryItemsInYear(_yearlyModel.year),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: _yearlyModel.pageIndex,
        onTap: (int index) {
          setState(() {
            _yearlyModel.pageIndex = index;
          });
        },
      ),
    );
  }
}
