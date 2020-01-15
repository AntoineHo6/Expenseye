import 'package:Expenseye/Components/Expenses/expenses_header.dart';
import 'package:Expenseye/Components/Global/add_expense_fab.dart';
import 'package:Expenseye/Components/Expenses/expense_list_tile.dart';
import 'package:Expenseye/Models/Expense.dart';
import 'package:Expenseye/Providers/daily_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Expenseye/Providers/Global/expense_model.dart';

class DailyExpensesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);
    final _dailyModel = Provider.of<DailyModel>(context);

    return Scaffold(
      body: FutureBuilder<List<Expense>>(
        future:
            _expenseModel.dbHelper.queryExpensesInDate(_dailyModel.currentDate),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data.length > 0) {
              _dailyModel.currentTotal = _expenseModel.calcTotal(snapshot.data);
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ExpensesHeader(
                      total: _expenseModel.totalString(snapshot.data),
                      pageModel: _dailyModel,
                    ),
                    Column(
                      children: snapshot.data.map(
                        (expense) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            color: MyColors.black02dp,
                            child: ExpenseListTile(
                              expense,
                              onTap: () => _expenseModel.openEditExpense(
                                  context, expense),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              );
            } else {
              return Align(
                alignment: Alignment.topCenter,
                child: ExpensesHeader(
                  total: _expenseModel.totalString(snapshot.data),
                  pageModel: _dailyModel,
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
      floatingActionButton: AddExpenseFab(
        onPressed: () =>
            _expenseModel.showAddExpense(context, _dailyModel.currentDate),
      ),
    );
  }
}
