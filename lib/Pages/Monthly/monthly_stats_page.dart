import 'package:expense_app/Components/Stats/category_stats_container.dart';
import 'package:expense_app/Components/Stats/legend_container.dart';
import 'package:expense_app/Components/Global/my_drawer.dart';
import 'package:expense_app/Components/Stats/simple_pie_chart.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Providers/monthly_model.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/chart_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyStatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context, listen: false);
    final _monthlyModel = Provider.of<MonthlyModel>(context, listen: false);

    return Scaffold(
      backgroundColor: MyColors.black00dp,
      drawer: const MyDrawer(),
      body: FutureBuilder<List<Expense>>(
        future: _expenseModel.dbHelper
            .queryExpensesInMonth(_monthlyModel.yearMonth),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
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
                                  data: aggregatedExpenses[0].data,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.all(15),
                            child: CategoryStatsContainer(
                              data: aggregatedExpenses[0].data,
                              monthsTotal: _monthlyModel.currentMonthsTotal,
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
                child: const Text(Strings.dataIsNull),
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
