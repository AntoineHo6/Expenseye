import 'package:expense_app_beginner/Components/add_expense.dart';
import 'package:expense_app_beginner/Pages/expand_expense.dart';
import 'package:expense_app_beginner/Components/my_drawer.dart';
import 'package:expense_app_beginner/Models/Expense.dart';
import 'package:expense_app_beginner/Resources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_app_beginner/ChangeNotifiers/Global/expense_model.dart';

class TodayPage extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.todaysExpenses),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(horizontal: 20),
            //color: Colors.amber,
            child: Text(
              Strings.total + ': ' + _expenseModel.calcTodaysTotal().toString(),
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          Expanded(
            child: ListView(
              children: _expenseModel.todaysExpenses
                  .map(
                    (expense) => Card(
                      child: ListTile(
                        leading: Icon(Icons.fastfood),
                        title: Text(expense.name),
                        subtitle: Text(expense.price.toString()),
                        onLongPress: () => _openExpandExpense(expense),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
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

  void _openExpandExpense(Expense expense) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExpandExpense(expense)),
    );
  }
}
