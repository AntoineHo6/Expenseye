import 'package:Expenseye/Components/Items/items_header.dart';
import 'package:Expenseye/Components/Global/colored_dot.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Pages/Monthly/monthly_home_page.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Providers/yearly_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearlyItemsPage extends StatelessWidget {
  final Function goToMonthPage;

  YearlyItemsPage({this.goToMonthPage});

  @override
  Widget build(BuildContext context) {
    final _itemModel = Provider.of<ItemModel>(context);
    final _yearlyModel = Provider.of<YearlyModel>(context);

    return Scaffold(
      body: FutureBuilder<List<Item>>(
        future: _itemModel.dbHelper.queryItemsInYear(_yearlyModel.year),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              var expensesSplitByMonth =
                  _yearlyModel.splitItemByMonth(snapshot.data);

              _itemModel.calcTotals(_yearlyModel, snapshot.data);

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ItemsHeader(
                            pageModel: _yearlyModel,
                          ),
                          Column(
                            children: _expensesSplitByMonthToContainers(
                              context,
                              expensesSplitByMonth,
                              _itemModel,
                              _yearlyModel,
                            ),
                          ),
                        ],
                      ),
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

  List<InkWell> _expensesSplitByMonthToContainers(
      BuildContext context,
      List<List<Item>> expensesSplitByMonth,
      ItemModel itemModel,
      YearlyModel yearlyModel) {
    return expensesSplitByMonth
        .map(
          (expenseList) => InkWell(
            onTap: () {
              yearlyModel.prepMonthPage(context, expenseList[0].date);
              goToMonthPage();
            },
            borderRadius: BorderRadius.circular(15),
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.black06dp,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(
                  top: 4, left: 15, right: 15, bottom: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        DateTimeUtil.monthNames[expenseList[0].date.month],
                        style: Theme.of(context).textTheme.title,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 16),
                        child: Text(
                            itemModel.totalString(yearlyModel.currentTotal)),
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
                      children: List.generate(expenseList.length, (index) {
                        return ColoredDot(
                            color: ItemModel
                                .catMap[expenseList[index].category]
                                .color);
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  void openMonthsPage(BuildContext context, DateTime date) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MonthlyHomePage()),
    );
  }
}
