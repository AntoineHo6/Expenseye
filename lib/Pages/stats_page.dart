import 'package:expense_app/Components/my_drawer.dart';
import 'package:expense_app/Components/simple_pie_chart.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/chart_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);

    return Scaffold(
        backgroundColor: MyColors.periwinkle,
        appBar: AppBar(
          title: Text('Statistics'),
        ),
        drawer: MyDrawer(),
        body: FutureBuilder<List<Expense>>(
            future: _expenseModel.dbHelper.queryAllExpenses(), // temp
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  var aggregatedExpenses =
                      ChartUtil.convertExpensesToChartSeries(snapshot.data);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        color: Colors.amber,
                        child: Column(
                          children: <Widget>[
                            Text(Strings.pieChart,
                                style: Theme.of(context).textTheme.headline),
                            Container(
                              //color: Colors.black45,
                              child: SizedBox(
                                height: 250.0,
                                child: SimplePieChart(aggregatedExpenses),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.black38,
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
            }));
  }
}
