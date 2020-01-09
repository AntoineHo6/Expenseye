import 'package:expense_app/Components/my_drawer.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:expense_app/Utils/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthlyPage extends StatefulWidget {
  @override
  _MonthlyPageState createState() => _MonthlyPageState();
}

class _MonthlyPageState extends State<MonthlyPage> {
  DateTime _currentDate = DateTime.now();
  String _yearMonth = '2020-01';

  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);

    return Scaffold(
      backgroundColor: MyColors.black00dp,
      appBar: AppBar(
        title: Text(DateTimeUtil.monthAbb[_currentDate.month]),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () => _chooseMonth(_currentDate),
            child: const Icon(Icons.calendar_today),
            shape: CircleBorder(
              side: const BorderSide(color: Colors.transparent),
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: FutureBuilder<List<Expense>>(
        future: _expenseModel.dbHelper.queryExpensesInMonth(_yearMonth),
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
    );
  }

  void _chooseMonth(DateTime initialDate) async {
    DateTime newMonth = await showMonthPicker(
      context: context,
      initialDate: initialDate,
    );

    if (newMonth != null) {
      _currentDate = newMonth;

      setState(() {
        _yearMonth = _getYearMonthString(newMonth);
      });
    }
  }

  String _getYearMonthString(DateTime newMonth) {
    String temp = newMonth.toIso8601String().split('T')[0];

    return temp.substring(0, temp.length - 3);
  }
}
