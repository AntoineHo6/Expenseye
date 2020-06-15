import 'package:Expenseye/Components/Drawer/my_drawer.dart';
import 'package:Expenseye/Components/Stats/category_stats_container.dart';
import 'package:Expenseye/Components/Stats/pie_outside_label_chart.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Utils/chart_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';

typedef GetItems = Future<List<Item>> Function();

class StatsPage extends StatelessWidget {
  final localModel;
  final GetItems future;

  StatsPage({
    @required this.localModel,
    @required this.future,
  }) : assert(localModel != null);

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
                  ChartUtil.convertExpensesToChartSeries(snapshot.data);
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)
                                .translate('expenses'),
                            style: Theme.of(context)
                                .textTheme
                                .headline5,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 220.0,
                            child: PieOutsideLabelChart(
                              aggregatedItems,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: CategoryStatsContainer(
                        data: aggregatedItems[0].data,
                        totalCost:
                            _calcExpensesTotal(aggregatedItems[0].data),
                      ),
                    ),
                  ],
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

  double _calcExpensesTotal(List<ExpenseGroup> expenseGroups) {
    double total = 0;

    for (var expenseGroup in expenseGroups) {
      total += (expenseGroup.total);
    }

    return total;
  }
}
