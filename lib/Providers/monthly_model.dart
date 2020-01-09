import 'package:expense_app/Components/expense_list_tile.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:expense_app/Utils/date_time_util.dart';
import 'package:flutter/material.dart';

class MonthlyModel extends ChangeNotifier {
  List<List<Expense>> splitExpensesByDay(List<Expense> expenses) {
    List<List<Expense>> expensesSplitByDay = new List();

    DateTime currentDate = expenses[0].date;
    int currentIndex = 0;
    expensesSplitByDay.add(List());

    for (Expense expense in expenses) {
      if (expense.date == currentDate) {
        expensesSplitByDay[currentIndex].add(expense);
      } else {
        currentIndex++;
        currentDate = expense.date;
        expensesSplitByDay.add(List());
        expensesSplitByDay[currentIndex].add(expense);
      }
    }

    return expensesSplitByDay;
  }

  List<Container> expensesSplitByDayToContainers(
      BuildContext context, List<List<Expense>> expensesSplitByDay) {
    return expensesSplitByDay
        .map(
          (expenseList) => Container(
            decoration: BoxDecoration(
              color: MyColors.black12dp, // tODO: get a slightly darker shade
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(12),
            margin:
                const EdgeInsets.only(top: 4, left: 20, right: 20, bottom: 20),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: <Widget>[
                      Text(
                        DateTimeUtil.formattedDate(expenseList[0].date),
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text('total amount of that day'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: _expensesToCardList(expenseList),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  // TODO: turn private
  List<Card> _expensesToCardList(List<Expense> expenses) {
    return expenses
        .map(
          (expense) => Card(
            margin: const EdgeInsets.only(top: 4, bottom: 4),
            color: MyColors.black02dp,
            child: ExpenseListTile(
              expense: expense,
            ),
          ),
        )
        .toList();
  }
}
