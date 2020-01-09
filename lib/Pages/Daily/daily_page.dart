import 'package:expense_app/Components/AlertDialogs/add_expense_dialog.dart';
import 'package:expense_app/Components/my_drawer.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Pages/edit_expense_page.dart';
import 'package:expense_app/Pages/table_calendar_page.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';

class DailyPage extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<DailyPage> {
  // don't include todays time for uniform data
  DateTime _currentDate = DateTimeUtil.cleanDateTime(DateTime.now());
  
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);

    return Scaffold(
      backgroundColor: MyColors.black00dp,
      appBar: AppBar(
        title: Text(_expenseModel.formattedDate(_currentDate)),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: _openTableCalendarPage,
            child: const Icon(Icons.calendar_today),
            shape: CircleBorder(
              side: const BorderSide(color: Colors.transparent),
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: FutureBuilder<List<Expense>>(
        future:
            _expenseModel.dbHelper.queryExpensesInDate(_currentDate),
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
                          margin: const EdgeInsets.only(
                              left: 15, right: 15, top: 4, bottom: 4),
                          color: MyColors.black02dp,
                          child: ListTile(
                            leading: Icon(
                                _expenseModel.catToIconData(expense.category),
                                color: CategoryProperties
                                    .properties[expense.category]['color']),
                            title: Text(
                              expense.name,
                              style: Theme.of(context).textTheme.subhead,
                            ),
                            subtitle: Text(
                              expense.price.toString(),
                              style: Theme.of(context).textTheme.subtitle,
                            ),
                            onTap: () => _openEditExpense(expense),
                            trailing: Text(
                              _expenseModel.formattedDate(expense.date),
                              style: Theme.of(context).textTheme.subtitle,
                            ),
                          ),
                        );
                      },
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
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddExpense(_currentDate),
        elevation: 2,
        backgroundColor: MyColors.secondary,
      ),
    );
  }

  void _showAddExpense(DateTime date) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => AddExpenseDialog(date),
    );

    if (confirmed) {
      final snackBar = SnackBar(
        content: Text(Strings.succAdded),
        backgroundColor: Colors.grey.withOpacity(0.5),
      );

      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void _openEditExpense(Expense expense) async {
    int action = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditExpensePage(expense)),
    );

    if (action != null) {
      final snackBar = SnackBar(
        content:
            action == 1 ? Text(Strings.succEdited) : Text(Strings.succDeleted),
        backgroundColor: Colors.grey.withOpacity(0.5),
      );

      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void _openTableCalendarPage() async {
    DateTime newDate = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TableCalendarPage(_currentDate)),
    );

    if (newDate != null) {
      setState(() {
        _currentDate = newDate;
      });
    }
  }
}
