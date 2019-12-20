import 'package:expense_app_beginner/AddExpense.dart';
import 'package:expense_app_beginner/MyDrawer.dart';
import 'package:expense_app_beginner/Resources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_app_beginner/TodayModel.dart';

class TodayPage extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  void _openAddExpense() {
    showDialog(
      context: context,
      builder: (_) => AddExpense(),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodayModel>(builder: (context, todayModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(Strings.todaysExpenses),
        ),
        drawer: MyDrawer(),
        body: Center(
          child: ListView(
            children: todayModel.expenses
                .map(
                  (expense) => Card(
                    child: ListTile(
                      leading: Text(expense.price.toString()),
                      title: Text(expense.title),
                      trailing: Text(expense.time.toString()),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _openAddExpense,
        ),
      );
    });
  }
}
