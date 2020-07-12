import 'package:Expenseye/Components/Global/my_bottom_nav_bar.dart';
import 'package:Expenseye/Components/Global/period_chooser.dart';
import 'package:Expenseye/Pages/Yearly/yearly_transac_page.dart';
import 'package:Expenseye/Pages/stats_page.dart';
import 'package:Expenseye/Providers/Global/db_notifier.dart';
import 'package:Expenseye/Providers/yearly_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearlyHomePage extends StatefulWidget {
  @override
  _YearlyHomePageState createState() => _YearlyHomePageState();
}

class _YearlyHomePageState extends State<YearlyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _dbModel = Provider.of<DbNotifier>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) => YearlyModel(),
      child: Consumer<YearlyModel>(
        builder: (context, yearlyModel, child) => Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).translate('yearly')),
            actions: <Widget>[
              PeriodChooser(
                text: yearlyModel.year,
                onPressedLeft: yearlyModel.decrementYear,
                onPressedRight: yearlyModel.incrementYear,
              ),
            ],
          ),
          body: SafeArea(
            top: false,
            child: IndexedStack(
              index: yearlyModel.pageIndex,
              children: <Widget>[
                YearlyTransacPage(),
                StatsPage(
                  future: () => _dbModel.queryTransacsInYear(yearlyModel.year),
                ),
              ],
            ),
          ),
          bottomNavigationBar: MyBottomNavBar(
            currentIndex: yearlyModel.pageIndex,
            onTap: (int index) {
              setState(() {
                yearlyModel.pageIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
