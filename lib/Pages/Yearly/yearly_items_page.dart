import 'package:Expenseye/Components/Items/items_header.dart';
import 'package:Expenseye/Components/Global/colored_dot.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Pages/Monthly/monthly_home_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Providers/yearly_model.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearlyItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _itemModel = Provider.of<ItemModel>(context);
    final _yearlyModel = Provider.of<YearlyModel>(context);

    return Scaffold(
      body: FutureBuilder<List<Item>>(
        future:
            Provider.of<DbModel>(context).queryItemsInYear(_yearlyModel.year),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              var itemsSplitByMonth =
                  _yearlyModel.splitItemByMonth(snapshot.data);
              _itemModel.calcTotals(_yearlyModel, snapshot.data);
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: itemsSplitByMonth.length + 1,
                      itemBuilder: (context, i) {
                        if (i == 0) {
                          return ItemsHeader(
                            pageModel: _yearlyModel,
                          );
                        }
                        return _MonthContainer(itemsSplitByMonth[i - 1]);
                      },
                    ),
                  ),
                ],
              );
            } else {
              _itemModel.calcTotals(_yearlyModel, snapshot.data);
              return Align(
                alignment: Alignment.topCenter,
                child: ItemsHeader(
                  pageModel: _yearlyModel,
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
    );
  }
}

class _MonthContainer extends StatelessWidget {
  final List<Item> items;

  _MonthContainer(this.items);

  @override
  Widget build(BuildContext context) {
    final _itemModel = Provider.of<ItemModel>(context);

    return Container(
      margin: const EdgeInsets.only(
        top: 4,
        left: 10,
        right: 10,
        bottom: 15,
      ),
      child: RaisedButton(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        onPressed: () => openMonthsPage(context, items[0].date),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)
                      .translate(DateTimeUtil.monthNames[items[0].date.month]),
                  style: Theme.of(context).textTheme.headline5,
                ),
                Container(
                  margin: EdgeInsets.only(right: 11),
                  child: Text(
                    _itemModel.totalString(
                      _itemModel.calcItemsTotal(items),
                    ),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: List.generate(
                  items.length,
                  (index) {
                    return ColoredDot(
                      color: DbModel.catMap[items[index].categoryId].color,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openMonthsPage(BuildContext context, DateTime date) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MonthlyHomePage(
          date: date,
          isMonthPickerVisible: false,
        ),
      ),
    );
  }
}
