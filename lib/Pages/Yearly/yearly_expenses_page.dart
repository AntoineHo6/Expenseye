import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Providers/yearly_model.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearlyExpensesPage extends StatefulWidget {
  @override
  _YearlyExpensesPageState createState() => _YearlyExpensesPageState();
}

class _YearlyExpensesPageState extends State<YearlyExpensesPage> {
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
              print('AM IN YEARLY');
              //_yearlyModel.splitExpenseByMonth(snapshot.data);
              _yearlyModel.currentTotal =
                  _expenseModel.calcTotal(snapshot.data);

              return Container();

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
}
