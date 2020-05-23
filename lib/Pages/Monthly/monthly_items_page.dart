import 'package:Expenseye/Components/Items/items_header.dart';
import 'package:Expenseye/Components/Global/add_item_fab.dart';
import 'package:Expenseye/Components/Items/item_list_tile.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Providers/monthly_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _itemModel = Provider.of<ItemModel>(context);
    final _monthlyModel = Provider.of<MonthlyModel>(context);
    final _dbModel = Provider.of<DbModel>(context);

    return Scaffold(
      body: FutureBuilder<List<Item>>(
        future: _dbModel.queryItemsByMonth(_monthlyModel.yearMonth),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              var expensesSplitByDay =
                  _monthlyModel.splitItemsByDay(snapshot.data);

              _itemModel.calcTotals(_monthlyModel, snapshot.data);

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ItemsHeader(
                            pageModel: _monthlyModel,
                          ),
                          Column(
                            children: _expensesSplitByDayToContainers(
                                context, expensesSplitByDay),
                          ),
                        ],
                      ),
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

  // ? Move to components?
  List<Container> _expensesSplitByDayToContainers(
      BuildContext context, List<List<Item>> expensesSplitByDay) {
    // ? pass models by arg?
    final _itemModel = Provider.of<ItemModel>(context, listen: false);

    return expensesSplitByDay
        .map(
          (itemList) => Container(
            decoration: BoxDecoration(
              color: MyColors.black06dp,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(12),
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      DateTimeUtil.formattedDate(context, itemList[0].date),
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: Text(_itemModel
                          .totalString(_itemModel.calcItemsTotal(itemList))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: itemList
                      .map(
                        (item) => Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          color: item.type == ItemType.expense
                              ? MyColors.expenseColor
                              : MyColors.incomeColor,
                          child: ItemListTile(
                            item,
                            onTap: () => _itemModel.openEditItem(context, item),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
