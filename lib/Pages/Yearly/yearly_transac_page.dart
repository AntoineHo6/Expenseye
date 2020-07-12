import 'package:Expenseye/Components/Transac/monthly_yearly_header.dart';
import 'package:Expenseye/Components/Global/colored_dot.dart';
import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Pages/Monthly/monthly_home_page.dart';
import 'package:Expenseye/Providers/Global/db_notifier.dart';
import 'package:Expenseye/Providers/yearly_model.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Resources/Themes/app_colors.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:Expenseye/Utils/transac_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearlyTransacPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _yearlyModel = Provider.of<YearlyModel>(context);

    return Scaffold(
      body: FutureBuilder<List<Transac>>(
        future: Provider.of<DbNotifier>(context).queryTransacsInYear(_yearlyModel.year),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var transacsSplitByMonth = _yearlyModel.splitTransacsByMonth(snapshot.data);
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: transacsSplitByMonth.length + 1,
                    itemBuilder: (context, i) {
                      if (i == 0) {
                        String sqlYearCondition =
                            '${Strings.transacColumnDate} LIKE \'${_yearlyModel.year}%\'';
                        return MonthlyYearlyHeader(
                          title: _yearlyModel.getTitle(context),
                          incomesTotalFuture: DatabaseHelper.instance.queryIncomesTotal(
                            where: sqlYearCondition,
                          ),
                          expensesTotalFuture: DatabaseHelper.instance.queryExpensesTotal(
                            where: sqlYearCondition,
                          ),
                          balanceTotalFuture: DatabaseHelper.instance.queryTransacsTotal(
                            where: sqlYearCondition,
                          ),
                        );
                      }
                      return _MonthContainer(transacsSplitByMonth[i - 1]);
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
    );
  }
}

class _MonthContainer extends StatelessWidget {
  final List<Transac> transacs;

  _MonthContainer(this.transacs);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: RaisedButton(
        elevation: 3,
        padding: const EdgeInsets.all(10),
        onPressed: () => _openMonthsPage(context, transacs[0].date),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)
                      .translate(DateTimeUtil.monthNames[transacs[0].date.month]),
                  style: Theme.of(context).textTheme.headline5,
                ),
                Container(
                  margin: EdgeInsets.only(right: 11),
                  child: Text(
                    '${TransacUtil.calcTransacsTotal(transacs).toStringAsFixed(2)} \$',
                    style: TextStyle(
                      color: ColorChooserFromTheme.balanceColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: List.generate(
                  transacs.length,
                  (index) {
                    return ColoredDot(
                      color: DbNotifier.catMap[transacs[index].categoryId].color,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openMonthsPage(BuildContext context, DateTime date) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MonthlyHomePage(
          date: date,
          isMonthPickerVisible: false,
        ),
      ),
    );
  }
}
