import 'package:Expenseye/Components/Transac/monthly_yearly_header.dart';
import 'package:Expenseye/Components/Global/add_transac_fab.dart';
import 'package:Expenseye/Components/Transac/transacs_day_box.dart';
import 'package:Expenseye/Enums/transac_type.dart';
import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Providers/Global/db_notifier.dart';
import 'package:Expenseye/Providers/monthly_model.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/transac_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyTransacPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _monthlyModel = Provider.of<MonthlyModel>(context, listen: false);

    return Scaffold(
      body: FutureBuilder<List<Transac>>(
        initialData: [],
        future: Provider.of<DbNotifier>(context).queryTransacsByMonth(_monthlyModel.yearMonth),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var transacsSplitByDay = TransacUtil.splitTransacsByDay(snapshot.data);

            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: transacsSplitByDay.length + 1,
                    itemBuilder: (context, i) {
                      if (i == 0) {
                        String sqlMonthCondition =
                            '${Strings.transacColumnDate} LIKE \'${_monthlyModel.yearMonth}%\'';
                        return Column(
                          children: <Widget>[
                            MonthlyYearlyHeader(
                              title: _monthlyModel.getTitle(context),
                              incomesTotalFuture: DatabaseHelper.instance.queryIncomesTotal(
                                where: sqlMonthCondition,
                              ),
                              expensesTotalFuture: DatabaseHelper.instance.queryExpensesTotal(
                                where: sqlMonthCondition,
                              ),
                              balanceTotalFuture: DatabaseHelper.instance.queryTransacsTotal(
                                where: sqlMonthCondition,
                              ),
                            ),
                          ],
                        );
                      }
                      return TransacsDayBox(transacsSplitByDay[i - 1]);
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Align(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: AddTransacFab(
        onExpensePressed: () => TransacUtil.showAddTransacDialog(
            context, _monthlyModel.currentDate, TransacType.expense),
        onIncomePressed: () => TransacUtil.showAddTransacDialog(
            context, _monthlyModel.currentDate, TransacType.income),
      ),
    );
  }
}
