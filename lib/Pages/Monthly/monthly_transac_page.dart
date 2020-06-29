import 'package:Expenseye/Components/Transac/monthly_yearly_header.dart';
import 'package:Expenseye/Components/Global/add_transac_fab.dart';
import 'package:Expenseye/Components/Transac/transac_list_tile.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/transac_model.dart';
import 'package:Expenseye/Providers/Global/settings_notifier.dart';
import 'package:Expenseye/Providers/monthly_model.dart';
import 'package:Expenseye/Resources/Themes/app_colors.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyTransacPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _transacModel = Provider.of<TransacModel>(context, listen: false);
    final _monthlyModel = Provider.of<MonthlyModel>(context, listen: false);

    return Scaffold(
      body: FutureBuilder<List<Transac>>(
        future: Provider.of<DbModel>(context)
            .queryTransacsByMonth(_monthlyModel.yearMonth),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              var transacsSplitByDay =
                  _monthlyModel.splitTransacsByDay(snapshot.data);

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
                        return _DayContainer(transacsSplitByDay[i - 1]);
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
        onExpensePressed: () =>
            _transacModel.showAddExpense(context, _monthlyModel.currentDate),
        onIncomePressed: () =>
            _transacModel.showAddIncome(context, _monthlyModel.currentDate),
      ),
    );
  }
}

class _DayContainer extends StatelessWidget {
  final List<Transac> transacs;

  _DayContainer(this.transacs);

  @override
  Widget build(BuildContext context) {
    final _transacModel = Provider.of<TransacModel>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10, right: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  DateTimeUtil.formattedDate(context, transacs[0].date),
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  '${_transacModel.totalString(_transacModel.calcTransacsTotal(transacs))}',
                  style: TextStyle(
                    color: ColorChooserFromTheme.balanceColorChooser(
                      Provider.of<SettingsNotifier>(context).getTheme(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: transacs
                .map(
                  (transac) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: TransacListTile(
                      transac,
                      onPressed: () => transac.openEditTransacPage(context, transac),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}