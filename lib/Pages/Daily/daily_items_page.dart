import 'package:Expenseye/Components/Items/items_header.dart';
import 'package:Expenseye/Components/Global/add_expense_fab.dart';
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
    final _expenseModel = Provider.of<ItemModel>(context);
    final _dailyModel = Provider.of<DailyModel>(context);

    return Scaffold(
      body: FutureBuilder<List<Item>>(
        future:
            _expenseModel.dbHelper.queryItemsInDate(_dailyModel.currentDate),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              _dailyModel.currentTotal = _expenseModel.calcTotal(snapshot.data);
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ItemsHeader(
                      total: _expenseModel.totalString(snapshot.data),
                      pageModel: _dailyModel,
                    ),
                    Column(
                      children: snapshot.data.map(
                        (expense) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            color: MyColors.black02dp,
                            child: ItemListTile(
                              expense,
                              onTap: () => _expenseModel.openEditItem(
                                  context, expense),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              );
            } else {
              return Align(
                alignment: Alignment.topCenter,
                child: ItemsHeader(
                  total: _expenseModel.totalString(snapshot.data),
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
        onPressed: () =>
            _expenseModel.showAddItem(context, _dailyModel.currentDate),
      ),
    );
  }
}
