import 'package:expense_app/Components/Buttons/FlatButton/app_bar_calendar_btn.dart';
import 'package:expense_app/Components/expense_list_tile.dart';
import 'package:expense_app/Components/my_drawer.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Providers/daily_model.dart';
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
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);
    final _dailyModel = Provider.of<DailyModel>(context);

    return Scaffold(
      backgroundColor: MyColors.black00dp,
      appBar: AppBar(
        title: Text(DateTimeUtil.formattedDate(_dailyModel.currentDate)),
        actions: <Widget>[
          AppBarCalendarBtn(
            onPressed: () => _dailyModel.openTableCalendarPage(context),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: FutureBuilder<List<Expense>>(
        future:
            _expenseModel.dbHelper.queryExpensesInDate(_dailyModel.currentDate),
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
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        Expense expense = snapshot.data[index];
                        return Card(
                          margin: const EdgeInsets.only(
                              left: 15, right: 15, top: 4, bottom: 4),
                          color: MyColors.black02dp,
                          child: ExpenseListTile(
                            expense: expense,
                            onTap: () =>
                                _dailyModel.openEditExpense(context, expense),
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
        onPressed: () => _dailyModel.showAddExpense(context),
        elevation: 2,
        backgroundColor: MyColors.secondary,
      ),
    );
  }
}
