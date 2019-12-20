import 'package:expense_app_beginner/Components/AddExpense.dart';
import 'package:expense_app_beginner/Components/ExpandExpense.dart';
import 'package:expense_app_beginner/Components/MyDrawer.dart';
import 'package:expense_app_beginner/Resources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_app_beginner/Blocs/ExpenseBloc.dart';

class TodayPage extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  @override
  Widget build(BuildContext context) {
    final _expenseBloc = Provider.of<ExpenseBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.todaysExpenses),
      ),
      drawer: MyDrawer(),
      body: Center(
        child: ListView(
          children: _expenseBloc.expenses
              .map(
                (expense) => Card(
                  child: ListTile(
                    leading: Icon(Icons.fastfood),
                    title: Text(expense.title),
                    subtitle: Text(expense.price.toString()),
                    trailing: Text(expense.note),
                    onTap: _openExpandExpense,
                  ),
                ),
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openAddExpense(),
      ),
    );
  }

  void _openAddExpense() {
    showDialog(
      context: context,
      builder: (_) => AddExpense(),
      barrierDismissible: false,
    );
  }

  void _openExpandExpense() {
    showDialog(
      context: context,
      builder: (_) => ExpandExpense(),
      barrierDismissible: false,
    );
  }
}

