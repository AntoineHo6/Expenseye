import 'package:Expenseye/Components/Global/my_drawer.dart';
import 'package:Expenseye/Pages/Monthly/monthly_home_page.dart';
import 'package:Expenseye/Pages/Yearly/yearly_home_page.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Providers/monthly_model.dart';
import 'package:Expenseye/Providers/yearly_model.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/google_firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      length: 2,
      vsync: this,
      initialIndex: 0,
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
      // TODO: temp
      Provider.of<ItemModel>(context, listen: false).dbHelper.upgrade();
      GoogleFirebaseHelper.uploadDbFile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MonthlyModel>(
            create: (_) => MonthlyModel(DateTime.now())),
        ChangeNotifierProvider<YearlyModel>(create: (_) => YearlyModel()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(Strings.expenses),
          actions: <Widget>[],
          bottom: TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 15, top: 8),
                child: const Text(Strings.monthly),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15, top: 8),
                child: const Text(Strings.yearly),
              ),
            ],
          ),
        ),
        drawer: MyDrawer(),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            MonthlyHomePage(),
            YearlyHomePage(goToMonthPage: goToMonthPage),
          ],
        ),
      ),
    );
  }

  void goToMonthPage() {
    _tabController.animateTo(0);
  }
}
