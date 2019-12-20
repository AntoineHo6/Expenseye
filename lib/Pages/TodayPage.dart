import 'package:expense_app_beginner/AddExpense/AddExpense.dart';
import 'package:expense_app_beginner/Components/MyDrawer.dart';
import 'package:expense_app_beginner/Resources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_app_beginner/Blocs/TodayBloc.dart';

class TodayPage extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  @override
  Widget build(BuildContext context) {
    final todayBloc = Provider.of<TodayBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.todaysExpenses),
      ),
      drawer: MyDrawer(),
      body: Center(
        child: ListView(
          children: todayBloc.expenses
              .map(
                (expense) => Card(
                  child: ListTile(
                    leading: Text(expense.price.toString()),
                    title: Text(expense.title),
                    subtitle: Text(expense.note),
                    trailing: Text(expense.time.toString()),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => openAddExpense(context),
      ),
    );
  }
}

void openAddExpense(context) async {
  showDialog(
    context: context,
    builder: (_) => AddExpense(),
    barrierDismissible: false,
  );
}
