import 'package:Expenseye/Components/Transac/monthly_yearly_header.dart';
import 'package:Expenseye/Components/Global/add_transac_fab.dart';
import 'package:Expenseye/Components/Transac/transacs_day_box.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/transac_model.dart';
import 'package:Expenseye/Providers/monthly_model.dart';
import 'package:Expenseye/Utils/transac_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyTransacPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _transacModel = Provider.of<TransacModel>(context, listen: false);
    final _monthlyModel = Provider.of<MonthlyModel>(context, listen: false);

    return Scaffold(
      body: FutureBuilder<List<Transac>>(
        future: Provider.of<DbModel>(context).queryTransacsByMonth(_monthlyModel.yearMonth),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              var transacsSplitByDay = TransacUtil.splitTransacsByDay(snapshot.data);

              _transacModel.calcTotals(_monthlyModel, snapshot.data);

              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: transacsSplitByDay.length + 1,
                      itemBuilder: (context, i) {
                        if (i == 0) {
                          return MonthlyYearlyHeader(
                            pageModel: _monthlyModel,
                          );
                        }
                        return TransacsDayBox(transacsSplitByDay[i - 1]);
                      },
                    ),
                  ),
                ],
              );
            } else {
              _transacModel.calcTotals(_monthlyModel, snapshot.data);
              return Align(
                alignment: Alignment.topCenter,
                child: MonthlyYearlyHeader(
                  pageModel: _monthlyModel,
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
      floatingActionButton: AddTransacFab(
        onExpensePressed: () => _transacModel.showAddExpense(context, _monthlyModel.currentDate),
        onIncomePressed: () => _transacModel.showAddIncome(context, _monthlyModel.currentDate),
      ),
    );
  }
}
