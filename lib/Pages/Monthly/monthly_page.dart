import 'package:expense_app/Components/Buttons/FAB/add_expense_fab.dart';
import 'package:expense_app/Components/my_drawer.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Providers/monthly_model.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyPage extends StatefulWidget {
  @override
  _MonthlyPageState createState() => _MonthlyPageState();
}

class _MonthlyPageState extends State<MonthlyPage> {
  DateTime _currentDate = DateTime.now();
  String _yearMonth = _getYearMonthString(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);
    final _monthlyModel = Provider.of<MonthlyModel>(context);

    return Scaffold(
      backgroundColor: MyColors.black00dp,
      appBar: AppBar(
        title: Text(
          '${DateTimeUtil.monthNames[_currentDate.month]} ${_currentDate.year}',
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () => _chooseMonth(_currentDate),
            child: const Icon(Icons.calendar_today),
            shape: const CircleBorder(
              side: const BorderSide(color: Colors.transparent),
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: FutureBuilder<List<Expense>>(
        future: _expenseModel.dbHelper.queryExpensesInMonth(_yearMonth),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              var expensesSplitByDay =
                  _monthlyModel.splitExpensesByDay(snapshot.data);
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
                            children:
                                _monthlyModel.expensesSplitByDayToContainers(
                                    context, expensesSplitByDay),
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
        onPressed: () => _expenseModel.showAddExpense(context, _currentDate),
      ),
    );
  }

  void _chooseMonth(DateTime initialDate) async {
    DateTime newMonth = await DateTimeUtil.chooseMonth(context, initialDate);

    if (newMonth != null) {
      _currentDate = newMonth;

      setState(() {
        _yearMonth = _getYearMonthString(newMonth);
      });
    }
  }

  static String _getYearMonthString(DateTime newMonth) {
    String temp = newMonth.toIso8601String().split('T')[0];

    return temp.substring(0, temp.length - 3);
  }
}
