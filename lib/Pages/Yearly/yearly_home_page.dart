import 'package:Expenseye/Components/Global/calendar_flat_button.dart';
import 'package:Expenseye/Components/Global/my_bottom_nav_bar.dart';
import 'package:Expenseye/Components/Global/my_drawer.dart';
import 'package:Expenseye/Pages/Yearly/yearly_expenses_page.dart';
import 'package:Expenseye/Pages/stats_page.dart';
import 'package:Expenseye/Providers/Global/expense_model.dart';
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
    final _expenseModel = Provider.of<ExpenseModel>(context);
    final _yearlyModel = Provider.of<YearlyModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_yearlyModel.year),
        actions: <Widget>[
          CalendarFlatButton(
            onPressed: () => showYearPicker(_yearlyModel),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _yearlyModel.pageIndex,
          children: <Widget>[
            YearlyExpensesPage(goToMonthPage: widget.goToMonthPage),
            StatsPage(
              localModel: _yearlyModel,
              future: () =>
                  _expenseModel.dbHelper.queryExpensesInYear(_yearlyModel.year),
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

  void showYearPicker(YearlyModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: YearPicker(
            selectedDate: model.currentDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2030),
            onChanged: (date) {
              model.updateCurrentDate(date);
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}
