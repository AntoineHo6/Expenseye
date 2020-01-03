import 'package:expense_app/Components/add_expense.dart';
import 'package:expense_app/Components/my_drawer.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Pages/edit_expense_page.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';

class TodayPage extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);

    return Scaffold(
      backgroundColor: MyColors.periwinkle,
      appBar: AppBar(
        title: Text(Strings.todaysExpenses),
      ),
      drawer: MyDrawer(),
      body: FutureBuilder<List<Expense>>(
        future: _expenseModel.dbHelper.queryAllExpenses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      _expenseModel.totalString(snapshot.data),
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.fastfood),
                            title: Text(snapshot.data[index].name),
                            subtitle:
                                Text(snapshot.data[index].price.toString()),
                            onLongPress: () =>
                                _openExpandExpense(snapshot.data[index]),
                            trailing: Text(
                              _expenseModel
                                  .formattedDate(snapshot.data[index].date),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Align(
                alignment: Alignment.center,
                child: Text(Strings.dataIsNull),
              );
            }
          } else {
            return Align(
              alignment: Alignment.center,
              child: new CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddExpense(),
      ),
    );
  }

  void _showAddExpense() {
    Provider.of<ExpenseModel>(context).dbHelper.deleteAllData();

    showDialog(
      context: context,
      builder: (_) => AddExpense(),
      barrierDismissible: false,
    );
  }

  void _openExpandExpense(Expense expense) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditExpense(expense)),
    );
  }
}
