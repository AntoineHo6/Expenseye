import 'package:Expenseye/Components/Items/items_header.dart';
import 'package:Expenseye/Components/Global/add_item_fab.dart';
import 'package:Expenseye/Components/Items/item_list_tile.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Providers/monthly_model.dart';
import 'package:Expenseye/Resources/Themes/MyColors.dart';
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
              var itemsSplitByDay =
                  _monthlyModel.splitItemsByDay(snapshot.data);

              _itemModel.calcTotals(_monthlyModel, snapshot.data);

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ItemsHeader(
                      pageModel: _monthlyModel,
                    ),
                    _itemsListView(context, itemsSplitByDay),
                  ],
                ),
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

  ListView _itemsListView(
      BuildContext context, List<List<Item>> itemsSplitByDay) {
    final _itemModel = Provider.of<ItemModel>(context, listen: false);

    return ListView.builder(
      addAutomaticKeepAlives: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: itemsSplitByDay.length,
      itemBuilder: (context, i) {
        return Container(
          decoration: BoxDecoration(
            color: MyColors.black06dp,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(12),
          margin:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 15),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    DateTimeUtil.formattedDate(
                        context, itemsSplitByDay[i][0].date),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: Text(_itemModel.totalString(
                        _itemModel.calcItemsTotal(itemsSplitByDay[i]))),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: itemsSplitByDay[i]
                    .map(
                      (item) => Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        color: item.type == ItemType.expense
                            ? MyColors.expenseBGColor
                            : MyColors.incomeBGColor,
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
        );
      },
    );
  }
}
