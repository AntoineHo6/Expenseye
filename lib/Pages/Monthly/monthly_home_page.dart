import 'package:Expenseye/Components/Global/my_bottom_nav_bar.dart';
import 'package:Expenseye/Components/Global/my_drawer.dart';
import 'package:Expenseye/Helpers/google_firebase_helper.dart';
import 'package:Expenseye/Pages/Monthly/monthly_items_page.dart';
import 'package:Expenseye/Pages/stats_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/monthly_model.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyHomePage extends StatefulWidget {
  final DateTime date;

  MonthlyHomePage(this.date);

  @override
  _MonthlyHomePageState createState() => _MonthlyHomePageState();
}

class _MonthlyHomePageState extends State<MonthlyHomePage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
    final _dbModel = Provider.of<DbModel>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) => MonthlyModel(widget.date),
      child: Consumer<MonthlyModel>(
        builder: (context, monthlyModel, child) => Scaffold(
          appBar: AppBar(
            title: Text(Strings.monthly),
          ),
          drawer: MyDrawer(),
          body: SafeArea(
            top: false,
            child: IndexedStack(
              index: monthlyModel.pageIndex,
              children: <Widget>[
                MonthlyItemsPage(),
                StatsPage(
                  localModel: monthlyModel,
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
