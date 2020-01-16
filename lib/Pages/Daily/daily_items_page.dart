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
              _expenseModel.calcTotals(_dailyModel, snapshot.data);
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ItemsHeader(
                      total:
                          '${_dailyModel.currentTotal.toStringAsFixed(2)}',
                      pageModel: _dailyModel,
                    ),
                    Column(
                      children: snapshot.data.map(
                        (item) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            color: item.type == 0
                                ? MyColors.expenseColor
                                : MyColors.incomeColor,
                            child: ItemListTile(
                              item,
                              onTap: () =>
                                  _expenseModel.openEditItem(context, item),
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
                  total: _expenseModel.totalString(_dailyModel.currentTotal),
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
            _expenseModel.showAddExpense(context, _dailyModel.currentDate),
            onIncomePressed: () =>
            _expenseModel.showAddIncome(context, _dailyModel.currentDate),
      ),
    );
  }
}
