import 'package:Expenseye/Pages/Categories/expenses_page.dart';
import 'package:Expenseye/Pages/Categories/incomes_page.dart';
import 'package:Expenseye/Providers/categories_model.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatHomePage extends StatefulWidget {
  @override
  _CatHomePageState createState() => _CatHomePageState();
}

class _CatHomePageState extends State<CatHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new CategoriesModel(),
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(controller: _tabController, tabs: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 15, top: 8),
              child: const Text(Strings.expenses),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15, top: 8),
              child: const Text(Strings.incomes),
            ),
          ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[ExpensesPage(), IncomesPage()],
        ),
      ),
    );
  }
}
