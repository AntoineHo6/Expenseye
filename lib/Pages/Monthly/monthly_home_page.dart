import 'package:Expenseye/Components/Global/my_bottom_nav_bar.dart';
import 'package:Expenseye/Components/Global/period_chooser.dart';
import 'package:Expenseye/Pages/Monthly/monthly_items_page.dart';
import 'package:Expenseye/Pages/stats_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/monthly_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyHomePage extends StatefulWidget {
  final DateTime date;
  final bool isMonthPickerVisible;

  MonthlyHomePage({@required this.date, this.isMonthPickerVisible = true});

  @override
  _MonthlyHomePageState createState() => _MonthlyHomePageState();
}

class _MonthlyHomePageState extends State<MonthlyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _dbModel = Provider.of<DbModel>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) => MonthlyModel(context, widget.date),
      child: Consumer<MonthlyModel>(
        builder: (context, monthlyModel, child) => Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).translate('monthly')),
            actions: <Widget>[
              widget.isMonthPickerVisible
                  ? PeriodChooser(
                      text: monthlyModel.yearMonthAbbr,
                      onPressedLeft: () => monthlyModel.decrementMonth(context),
                      onPressedRight: () =>
                          monthlyModel.incrementMonth(context),
                    )
                  : Container(),
            ],
          ),
          body: SafeArea(
            top: false,
            child: IndexedStack(
              index: monthlyModel.pageIndex,
              children: <Widget>[
                MonthlyItemsPage(),
                StatsPage(
                  future: () =>
                      _dbModel.queryItemsByMonth(monthlyModel.yearMonth),
                ),
              ],
            ),
          ),
          bottomNavigationBar: MyBottomNavBar(
            currentIndex: monthlyModel.pageIndex,
            onTap: (int index) {
              setState(() {
                monthlyModel.pageIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
