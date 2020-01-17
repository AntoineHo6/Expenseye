import 'package:Expenseye/Components/Items/items_header.dart';
import 'package:Expenseye/Components/Global/add_item_fab.dart';
import 'package:Expenseye/Components/Items/item_list_tile.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/daily_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';

class DailyItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _itemModel = Provider.of<ItemModel>(context);
    final _dailyModel = Provider.of<DailyModel>(context);

    return Scaffold(
      body: FutureBuilder<List<Item>>(
        future: _itemModel.dbHelper.queryItemsInDate(_dailyModel.currentDate),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              //print('Building things');
              _itemModel.calcTotals(_dailyModel, snapshot.data);
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ItemsHeader(
                      pageModel: _dailyModel,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: MyColors.black06dp,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 15),
                      child: Column(
                        children: snapshot.data.map(
                          (item) {
                            return Card(
                              color: item.type == 0
                                  ? MyColors.expenseColor
                                  : MyColors.incomeColor,
                              child: ItemListTile(
                                item,
                                onTap: () =>
                                    _itemModel.openEditItem(context, item),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              _itemModel.calcTotals(_dailyModel, snapshot.data);
              return Align(
                alignment: Alignment.topCenter,
                child: ItemsHeader(
                  pageModel: _dailyModel,
                ),
              );
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
        onExpensePressed: () =>
            _itemModel.showAddExpense(context, _dailyModel.currentDate),
        onIncomePressed: () =>
            _itemModel.showAddIncome(context, _dailyModel.currentDate),
      ),
    );
  }
}
