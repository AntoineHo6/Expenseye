import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Pages/Categories/categories_page.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

class CatHomePage extends StatefulWidget {
  @override
  _CatHomePageState createState() => _CatHomePageState();
}

class _CatHomePageState extends State<CatHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<Widget> _pages = [
    CategoriesPage(ItemType.expense),
    CategoriesPage(ItemType.income),
  ];

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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('categories')),
        bottom: TabBar(controller: _tabController, tabs: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 15, top: 8),
            child: Text(AppLocalizations.of(context).translate('expenses')),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15, top: 8),
            child: Text(AppLocalizations.of(context).translate('incomes')),
          ),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
    );
  }
}
