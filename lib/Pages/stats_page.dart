import 'package:Expenseye/Components/Global/my_drawer.dart';
import 'package:Expenseye/Components/Stats/category_stats_container.dart';
import 'package:Expenseye/Components/Stats/legend_container.dart';
import 'package:Expenseye/Components/Stats/simple_pie_chart.dart';
import 'package:Expenseye/Models/Expense.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/chart_util.dart';
import 'package:flutter/material.dart';

typedef GetExpenses = Future<List<Expense>> Function();

class StatsPage extends StatelessWidget {

  final localModel;
  final GetExpenses future;

  StatsPage({@required this.localModel, @required this.future})
      : assert(localModel != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: FutureBuilder<List<Expense>>(
        future: future(),
            // _expenseModel.dbHelper.queryExpensesInMonth(localModel.yearMonth)
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              var aggregatedExpenses =
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
                                              .headline),
                                      Container(
                                        child: SizedBox(
                                          height: 250.0,
                                          child: SimplePieChart(
                                            aggregatedExpenses,
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
                                  aggregatedExpenses[0].data,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.all(15),
                            child: CategoryStatsContainer(
                              data: aggregatedExpenses[0].data,
                              totalCost: localModel.currentTotal,
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
}
