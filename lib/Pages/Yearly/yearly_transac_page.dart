import 'package:Expenseye/Components/Transac/monthly_yearly_header.dart';
import 'package:Expenseye/Components/Global/colored_dot.dart';
import 'package:Expenseye/Models/Transac.dart';
import 'package:Expenseye/Pages/Monthly/monthly_home_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/transac_model.dart';
import 'package:Expenseye/Providers/yearly_model.dart';
import 'package:Expenseye/Resources/Themes/app_colors.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:Expenseye/Utils/transac_util.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearlyTransacPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _transacModel = Provider.of<TransacModel>(context);
    final _yearlyModel = Provider.of<YearlyModel>(context);

    return Scaffold(
      body: FutureBuilder<List<Transac>>(
        future: Provider.of<DbModel>(context).queryTransacsInYear(_yearlyModel.year),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              var transacsSplitByMonth = _yearlyModel.splitTransacsByMonth(snapshot.data);
              _transacModel.calcTotals(_yearlyModel, snapshot.data);
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: transacsSplitByMonth.length + 1,
                      itemBuilder: (context, i) {
                        if (i == 0) {
                          return MonthlyYearlyHeader(
                            pageModel: _yearlyModel,
                          );
                        }
                        return _MonthContainer(transacsSplitByMonth[i - 1]);
                      },
                    ),
                  ),
                ],
              );
            } else {
              _transacModel.calcTotals(_yearlyModel, snapshot.data);
              return Align(
                alignment: Alignment.topCenter,
                child: MonthlyYearlyHeader(
                  pageModel: _yearlyModel,
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
    );
  }
}

class _MonthContainer extends StatelessWidget {
  final List<Transac> transacs;

  _MonthContainer(this.transacs);

  @override
  Widget build(BuildContext context) {
    final _transacModel = Provider.of<TransacModel>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: RaisedButton(
        elevation: 3,
        padding: const EdgeInsets.all(10),
        onPressed: () => openMonthsPage(context, transacs[0].date),
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
                    _transacModel.totalString(
                      TransacUtil.calcTransacsTotal(transacs),
                    ),
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
                      color: DbModel.catMap[transacs[index].categoryId].color,
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

  void openMonthsPage(BuildContext context, DateTime date) {
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
