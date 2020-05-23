import 'package:Expenseye/Components/Global/my_drawer.dart';
import 'package:Expenseye/Components/Stats/category_stats_container.dart';
import 'package:Expenseye/Components/Stats/legend_container.dart';
import 'package:Expenseye/Components/Stats/simple_pie_chart.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/chart_util.dart';
import 'package:flutter/material.dart';

typedef GetItems = Future<List<Item>> Function();

class StatsPage extends StatelessWidget {
  final localModel;
  final GetItems future;

  StatsPage({@required this.localModel, @required this.future})
      : assert(localModel != null);

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
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: <Widget>[
                                      Text(Strings.expenses,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5),
                                      Container(
                                        child: SizedBox(
                                          height: 250.0,
                                          child: SimplePieChart(
                                            aggregatedItems,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(20),
                                child: LegendContainer(
                                  aggregatedItems[0].data,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.all(15),
                            child: CategoryStatsContainer(
                              data: aggregatedItems[0].data,
                              totalCost:
                                  calcExpensesTotal(aggregatedItems[0].data),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Align(
                alignment: Alignment.center,
                child: const Text(Strings.noData),
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

  double calcExpensesTotal(List<ExpenseGroup> expenseGroups) {
    double total = 0;

    for (var expenseGroup in expenseGroups) {
      total += (expenseGroup.total);
    }

    return total;
  }
}
