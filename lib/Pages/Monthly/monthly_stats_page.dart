import 'package:expense_app/Components/Buttons/FlatButton/app_bar_calendar_btn.dart';
import 'package:expense_app/Components/ListTile/expense_group_list_tile.dart';
import 'package:expense_app/Components/colored_dot_container.dart';
import 'package:expense_app/Components/my_drawer.dart';
import 'package:expense_app/Components/simple_pie_chart.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Providers/monthly_model.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/chart_util.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyStatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context, listen: false);
    final _monthlyModel = Provider.of<MonthlyModel>(context, listen: false);

    return Scaffold(
      backgroundColor: MyColors.black00dp,
      appBar: AppBar(
        title: Text(_monthlyModel.getMonthlyTitle()),
        actions: <Widget>[
          AppBarCalendarBtn(
            onPressed: () =>
                _monthlyModel.openMonthlyTableCalendarPage(context),
          ),
        ],
      ),
      drawer: MyDrawer(),
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
                                              aggregatedExpenses),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: aggregatedExpenses[0].data.map(
                                    (expenseGroup) {
                                      if (expenseGroup.total > 0) {
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 6),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              ColoredDotContainer(
                                                color: CategoryProperties
                                                            .properties[
                                                        expenseGroup.category]
                                                    ['color'],
                                              ),
                                              SizedBox(width: 10),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                    CategoryProperties
                                                                .properties[
                                                            expenseGroup
                                                                .category]
                                                        ['string'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subhead),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ).toList(),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: aggregatedExpenses[0].data.map(
                              (expenseGroup) {
                                if (expenseGroup.total > 0) {
                                  return Card(
                                    color: MyColors.black02dp,
                                    child: ExpenseGroupListTile(
                                      expenseGroup: expenseGroup,
                                      monthsTotal:
                                          _monthlyModel.currentMonthsTotal,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ).toList(),
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
                child: Text(Strings.dataIsNull),
              );
            }
          } else {
            return Align(
              alignment: Alignment.center,
              child: new CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
