import 'package:expense_app/Components/Global/add_expense_fab.dart';
import 'package:expense_app/Components/Expenses/expense_list_tile.dart';
import 'package:expense_app/Components/Global/my_drawer.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Providers/daily_model.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';

class DailyExpensesPage extends StatefulWidget {
  @override
  _DailyExpensesPageState createState() => _DailyExpensesPageState();
}

class _DailyExpensesPageState extends State<DailyExpensesPage> {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);
    final _dailyModel = Provider.of<DailyModel>(context);

    return Scaffold(
      backgroundColor: MyColors.black00dp,
      drawer: MyDrawer(),
      body: FutureBuilder<List<Expense>>(
        future:
            _expenseModel.dbHelper.queryExpensesInDate(_dailyModel.currentDate),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              _dailyModel.currentTotal = _expenseModel.calcTotal(snapshot.data);
              return Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '${Strings.total}: ${_expenseModel.totalString(snapshot.data)}',
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: snapshot.data
                          .map(
                            (expense) => Card(
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 4, bottom: 4),
                              color: MyColors.black02dp,
                              child: ExpenseListTile(
                                expense: expense,
                                onTap: () => _expenseModel.openEditExpense(
                                    context, expense),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              );
            } else {
              return const Align(
                alignment: Alignment.center,
                child: const Text(Strings.dataIsNull),
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
            _expenseModel.showAddExpense(context, _dailyModel.currentDate),
      ),
    );
  }
}
