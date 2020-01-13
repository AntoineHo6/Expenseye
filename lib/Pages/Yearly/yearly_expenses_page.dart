import 'package:expense_app/Components/Global/colored_dot_container.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Pages/Monthly/monthly_home_page.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Providers/yearly_model.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearlyExpensesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);
    final _yearlyModel = Provider.of<YearlyModel>(context);

    return Scaffold(
      body: FutureBuilder<List<Expense>>(
        future: _expenseModel.dbHelper.queryExpensesInYear(_yearlyModel.year),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              var expensesSplitByMonth =
                  _yearlyModel.splitExpenseByMonth(snapshot.data);
              _yearlyModel.currentTotal =
                  _expenseModel.calcTotal(snapshot.data);

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              '${Strings.total}: ${_expenseModel.totalString(snapshot.data)}',
                              style: Theme.of(context).textTheme.display1,
                            ),
                          ),
                          Column(
                            children: _expensesSplitByMonthToContainers(
                                context, expensesSplitByMonth),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Align(
                alignment: Alignment.center,
                child: const Text(Strings.addAnExpense),
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

  List<InkWell> _expensesSplitByMonthToContainers(
      BuildContext context, List<List<Expense>> expensesSplitByMonth) {
    // TODO: recheck if good idea to reinstantiate model. Also in month
    final _expenseModel = Provider.of<ExpenseModel>(context, listen: false);

    return expensesSplitByMonth
        .map(
          (expenseList) => InkWell(
            onTap: () {
              // TODO: move this to model
              DateTime date = expenseList[0].date;
              DateTime nowDate = DateTime.now();
              if (date.year == nowDate.year && date.month == nowDate.month) {
                openMonthsPage(context, nowDate);
              } else {
                openMonthsPage(context, DateTime(date.year, date.month));
              }
            },
            borderRadius: BorderRadius.circular(15),
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.black06dp,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(
                  top: 4, left: 15, right: 15, bottom: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        DateTimeUtil.monthNames[expenseList[0].date.month],
                        style: Theme.of(context).textTheme.title,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 16),
                        child: Text(_expenseModel.totalString(expenseList)),
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
                      children: List.generate(expenseList.length, (index) {
                        return ColoredDotContainer(
                            color: CategoryProperties
                                    .properties[expenseList[index].category]
                                ['color']);
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  void openMonthsPage(BuildContext context, DateTime date) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MonthlyHomePage(date)),
    );
  }
}
