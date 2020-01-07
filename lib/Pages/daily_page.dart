import 'package:expense_app/Components/add_expense.dart';
import 'package:expense_app/Components/my_drawer.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Pages/edit_expense_page.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';

class DailyPage extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<DailyPage> {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);

    return Scaffold(
      backgroundColor: MyColors.periwinkle,
      appBar: AppBar(
        title: Text(_expenseModel.formattedDate(_expenseModel.dailyDate)),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white, // temp
            onPressed: () => chooseDate(DateTime.now(), _expenseModel),
            child: Icon(Icons.calendar_today),
            shape: CircleBorder(
              side: BorderSide(color: Colors.transparent),
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: FutureBuilder<List<Expense>>(
        future: _expenseModel.dbHelper.queryExpensesInDate(_expenseModel.dailyDate), // temp
        //future: _expenseModel.dbHelper.queryAllExpenses(), // temp
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      _expenseModel.totalString(snapshot.data),
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        Expense expense = snapshot.data[index];
                        return Card(
                          child: ListTile(
                            leading: Icon(
                                _expenseModel.catToIconData(expense.category),
                                color: CategoryProperties
                                    .properties[expense.category]['color']),
                            title: Text(expense.name),
                            subtitle: Text(expense.price.toString()),
                            onTap: () => _openEditExpense(expense),
                            trailing: Text(
                              _expenseModel.formattedDate(expense.date),
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
        elevation: 2,
      ),
    );
  }

  void _showAddExpense() {
    showDialog(
      context: context,
      builder: (_) => AddExpense(),
    );
  }

  void _openEditExpense(Expense expense) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditExpensePage(expense)),
    );
  }

  void chooseDate(DateTime initialDate, ExpenseModel _expenseModel) async {
    await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
              primarySwatch: MyColors.indigoInk,
              splashColor: MyColors.indigoInk),
          child: child,
        );
      },
    ).then((value) {
      _expenseModel.updateDate(value);
    });


  }
}
