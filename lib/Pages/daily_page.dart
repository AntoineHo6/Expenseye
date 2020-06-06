import 'package:Expenseye/Components/Global/add_item_fab.dart';
import 'package:Expenseye/Components/Drawer/my_drawer.dart';
import 'package:Expenseye/Components/Items/item_list_tile.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Helpers/google_firebase_helper.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyPage extends StatefulWidget {
  final DateTime day = DateTime.now();

  @override
  _DailyPageState createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> with WidgetsBindingObserver {
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
    final _itemModel = Provider.of<ItemModel>(context);
    final _dbModel = Provider.of<DbModel>(context);

    return Scaffold(
      drawer: MyDrawer(),
      body: FutureBuilder<List<Item>>(
        future: _dbModel.queryItemsByDay(widget.day),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              return mySliverView(snapshot.data, _itemModel, context);
            } else {
              return mySliverView([], _itemModel, context);
            }
          } else {
            return const Align(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: AddExpenseFab(
        onExpensePressed: () => _itemModel.showAddExpense(context, widget.day),
        onIncomePressed: () => _itemModel.showAddIncome(context, widget.day),
      ),
    );
  }

  CustomScrollView mySliverView(
      List<Item> items, ItemModel itemModel, BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 160,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              DateTimeUtil.formattedDate(context, widget.day),
              style: Theme.of(context).textTheme.headline1,
            ),
            centerTitle: true,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            items
                .map(
                  (item) => Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    decoration: BoxDecoration(
                      color: item.type == ItemType.expense
                          ? MyColors.expenseBGColor
                          : MyColors.incomeBGColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ItemListTile(
                      item,
                      onTap: () => itemModel.openEditItem(context, item),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
