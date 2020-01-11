import 'package:expense_app/Components/Global/add_expense_fab.dart';
import 'package:expense_app/Components/Global/calendar_flat_button.dart';
import 'package:expense_app/Components/Expenses/expense_list_tile.dart';
import 'package:expense_app/Components/Global/my_drawer.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Providers/monthly_model.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyExpensesPage extends StatefulWidget {
  @override
  _MonthlyExpensesPageState createState() => _MonthlyExpensesPageState();
}

class _MonthlyExpensesPageState extends State<MonthlyExpensesPage> {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);
    final _monthlyModel = Provider.of<MonthlyModel>(context);

    return Scaffold(
      backgroundColor: MyColors.black00dp,
      appBar: AppBar(
        title: Text(
          _monthlyModel.getMonthlyTitle(),
        ),
        actions: <Widget>[
          CalendarFlatButton(
            onPressed: () =>
                _monthlyModel.openMonthlyTableCalendarPage(context),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: FutureBuilder<List<Expense>>(
        future: _expenseModel.dbHelper
            .queryExpensesInMonth(_monthlyModel.yearMonth),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              var expensesSplitByDay =
                  _monthlyModel.splitExpensesByDay(snapshot.data);
              _monthlyModel.currentMonthsTotal =
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
                            children: _expensesSplitByDayToContainers(
                                expensesSplitByDay),
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
                child: Text(Strings.dataIsNull),
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
      floatingActionButton: AddExpenseFab(
        onPressed: () =>
            _expenseModel.showAddExpense(context, _monthlyModel.currentDate),
      ),
    );
  }

  // ? Move to components?
  List<Container> _expensesSplitByDayToContainers(
      List<List<Expense>> expensesSplitByDay) {
    final _expenseModel = Provider.of<ExpenseModel>(context, listen: false);

    return expensesSplitByDay
        .map(
          (expenseList) => Container(
            decoration: BoxDecoration(
              color: MyColors.black06dp,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(12),
            margin:
                const EdgeInsets.only(top: 4, left: 15, right: 15, bottom: 20),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      DateTimeUtil.formattedDate(expenseList[0].date),
                      style: Theme.of(context).textTheme.title,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Text(_expenseModel.totalString(expenseList)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: expenseList
                      .map(
                        (expense) => Card(
                          margin: const EdgeInsets.only(top: 4, bottom: 4),
                          color: MyColors.black02dp,
                          child: ExpenseListTile(
                            onTap: () =>
                                _expenseModel.openEditExpense(context, expense),
                            expense: expense,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
