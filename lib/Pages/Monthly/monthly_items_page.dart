import 'package:Expenseye/Components/Items/items_header.dart';
import 'package:Expenseye/Components/Global/add_expense_fab.dart';
import 'package:Expenseye/Components/Items/item_list_tile.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Providers/monthly_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ItemModel>(context);
    final _monthlyModel = Provider.of<MonthlyModel>(context);

    return Scaffold(
      body: FutureBuilder<List<Item>>(
        future: _expenseModel.dbHelper
            .queryItemsInMonth(_monthlyModel.yearMonth),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              var expensesSplitByDay =
                  _monthlyModel.splitItemsByDay(snapshot.data);
              _monthlyModel.currentTotal =
                  _expenseModel.calcTotal(snapshot.data);

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ItemsHeader(
                            total: _expenseModel.totalString(snapshot.data),
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
              return Align(
                alignment: Alignment.topCenter,
                child: ItemsHeader(
                  total: _expenseModel.totalString(snapshot.data),
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
        onPressed: () =>
            _expenseModel.showAddItem(context, _monthlyModel.currentDate),
      ),
    );
  }

  // ? Move to components?
  List<Container> _expensesSplitByDayToContainers(
      BuildContext context, List<List<Item>> expensesSplitByDay) {
    final _expenseModel = Provider.of<ItemModel>(context, listen: false);

    return expensesSplitByDay
        .map(
          (expenseList) => Container(
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
                      DateTimeUtil.formattedDate(expenseList[0].date),
                      style: Theme.of(context).textTheme.title,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: Text(_expenseModel.totalString(expenseList)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: expenseList
                      .map(
                        (expense) => Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          color: MyColors.black02dp,
                          child: ItemListTile(
                            expense,
                            onTap: () =>
                                _expenseModel.openEditItem(context, expense),
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
