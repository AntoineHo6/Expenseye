import 'package:Expenseye/Components/Drawer/my_drawer.dart';
import 'package:Expenseye/Components/Stats/category_stats_container.dart';
import 'package:Expenseye/Components/Stats/pie_outside_label_chart.dart';
import 'package:Expenseye/Enums/item_type.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Utils/chart_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

typedef GetItems = Future<List<Item>> Function();

class StatsPage extends StatelessWidget {
  final ItemType type;
  final Function onSwitchTypeBtnPressed;
  final GetItems future;

  StatsPage({
    @required this.type,
    @required this.onSwitchTypeBtnPressed,
    @required this.future,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: FutureBuilder<List<Item>>(
        future: future(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              var aggregatedItems =
                  ChartUtil.convertItemsToChartSeries(snapshot.data, type);
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        type == ItemType.expense
                            ? AppLocalizations.of(context).translate('expenses')
                            : AppLocalizations.of(context).translate('incomes'),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 200.0,
                        child: PieOutsideLabelChart(
                          aggregatedItems,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: RaisedButton(
                          onPressed: onSwitchTypeBtnPressed,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.swap_horiz),
                              const SizedBox(width: 5,),
                              Text(
                                type == ItemType.expense
                                    ? AppLocalizations.of(context)
                                        .translate('switchToIncomes')
                                    : AppLocalizations.of(context)
                                        .translate('switchToExpenses'),
                                        style: TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CategoryStatsContainer(
                        data: aggregatedItems[0].data,
                        totalCost: _calcTypeTotal(aggregatedItems[0].data),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Align(
                alignment: Alignment.center,
                child: Text(AppLocalizations.of(context).translate('noData')),
              );
            }
          } else {
            return Align(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  double _calcTypeTotal(List<CategoryGroup> categoryGroups) {
    double total = 0;

    for (var categoryGroup in categoryGroups) {
      total += (categoryGroup.total);
    }

    return total;
  }
}
