import 'package:Expenseye/Components/Items/items_header.dart';
import 'package:Expenseye/Components/Global/add_item_fab.dart';
import 'package:Expenseye/Components/Items/item_list_tile.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Providers/monthly_model.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _itemModel = Provider.of<ItemModel>(context, listen: false);
    final _monthlyModel = Provider.of<MonthlyModel>(context, listen: false);

    return Scaffold(
      body: FutureBuilder<List<Item>>(
        future: Provider.of<DbModel>(context)
            .queryItemsByMonth(_monthlyModel.yearMonth),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              var itemsSplitByDay =
                  _monthlyModel.splitItemsByDay(snapshot.data);

              _itemModel.calcTotals(_monthlyModel, snapshot.data);

              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: itemsSplitByDay.length + 1,
                      itemBuilder: (context, i) {
                        if (i == 0) {
                          return ItemsHeader(
                            pageModel: _monthlyModel,
                          );
                        }
                        return _DayContainer(itemsSplitByDay[i - 1]);
                      },
                    ),
                  ),
                ],
              );
            } else {
              _itemModel.calcTotals(_monthlyModel, snapshot.data);
              return Align(
                alignment: Alignment.topCenter,
                child: ItemsHeader(
                  pageModel: _monthlyModel,
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
            _itemModel.showAddExpense(context, _monthlyModel.currentDate),
        onIncomePressed: () =>
            _itemModel.showAddIncome(context, _monthlyModel.currentDate),
      ),
    );
  }
}

class _DayContainer extends StatelessWidget {
  final List<Item> items;

  _DayContainer(this.items);

  @override
  Widget build(BuildContext context) {
    final _itemModel = Provider.of<ItemModel>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  DateTimeUtil.formattedDate(context, items[0].date),
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  '${_itemModel.totalString(_itemModel.calcItemsTotal(items))}',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: items
                .map(
                  (item) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ItemListTile(
                      item,
                      onPressed: () => item.openEditItemPage(context, item),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
