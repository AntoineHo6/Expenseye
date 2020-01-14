import 'package:Expenseye/Components/Global/colored_dot.dart';
import 'package:Expenseye/Models/Expense.dart';
import 'package:Expenseye/Pages/Monthly/monthly_home_page.dart';
import 'package:Expenseye/Providers/Global/expense_model.dart';
import 'package:Expenseye/Providers/monthly_model.dart';
import 'package:Expenseye/Providers/yearly_model.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/Utils/date_time_util.dart';
import 'package:Expenseye/Utils/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearlyExpensesPage extends StatelessWidget {
  final PageController pageController;

  YearlyExpensesPage({this.pageController});

  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context, listen: false);
    final _yearlyModel = Provider.of<YearlyModel>(context, listen: false);

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
                                context, expensesSplitByMonth, _expenseModel),
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

  List<InkWell> _expensesSplitByMonthToContainers(BuildContext context,
      List<List<Expense>> expensesSplitByMonth, ExpenseModel expenseModel) {
    // TODO: recheck if good idea to reinstantiate model. Also in month

    return expensesSplitByMonth
        .map(
          (expenseList) => InkWell(
            onTap: () {
              // TODO: move this to model
              DateTime date = expenseList[0].date;
              DateTime nowDate = DateTime.now();
              if (date.year == nowDate.year && date.month == nowDate.month) {
                Provider.of<MonthlyModel>(context, listen: false)
                    .updateDate(nowDate);
                _goToMonthPage();
                //openMonthsPage(context, nowDate);
              } else {
                Provider.of<MonthlyModel>(context, listen: false)
                    .updateDate(DateTime(date.year, date.month));
                _goToMonthPage();
                //openMonthsPage(context, DateTime(date.year, date.month));
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
                        child: Text(expenseModel.totalString(expenseList)),
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
                        return ColoredDot(
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
      MaterialPageRoute(builder: (context) => MonthlyHomePage()),
    );
  }

  void _goToMonthPage() {
    pageController.animateToPage(
      1,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
