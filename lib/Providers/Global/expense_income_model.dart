import 'package:Expenseye/Components/EditAdd/add_expense_dialog.dart';
import 'package:Expenseye/Models/Expense.dart';
import 'package:Expenseye/Pages/EditAdd/edit_expense_page.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Utils/database_helper.dart';
import 'package:Expenseye/google_firebase_helper.dart';
import 'package:flutter/material.dart';

class ExpenseIncomeModel extends ChangeNotifier {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  ExpenseIncomeModel() {
    initConnectedUser();
  }

  void initConnectedUser() async {
    await GoogleFirebaseHelper.initConnectedUser();
  }

  void loginWithGoogle() async {
    List<Expense> localExpenses = await dbHelper.queryAllExpenses();

    bool isLoggedIn = await GoogleFirebaseHelper.loginWithGoogle();

    if (isLoggedIn && localExpenses.length > 0) {
      for (Expense expense in localExpenses) {
        await dbHelper.insertExpense(expense);
      }
    }

    notifyListeners();
  }

  void logOutFromGoogle() async {
    await GoogleFirebaseHelper.uploadDbFile();
    await GoogleFirebaseHelper.logOut();
    await dbHelper.deleteAll();
    notifyListeners();
  }

  void addExpense(Expense newExpense) async {
    await dbHelper.insertExpense(newExpense);
    notifyListeners();
  }

  void editExpense(Expense newExpense) async {
    await dbHelper.updateExpense(newExpense);
    notifyListeners();
  }

  void deleteExpense(int id) async {
    await dbHelper.deleteExpense(id);
    notifyListeners();
  }

  void showAddExpense(BuildContext context, DateTime initialDate) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (_) => AddExpenseDialog(initialDate),
    );

    if (confirmed != null && confirmed) {
      final snackBar = SnackBar(
        content: Text(Strings.succAdded),
        backgroundColor: Colors.grey.withOpacity(0.5),
      );

      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void openEditExpense(BuildContext context, Expense expense) async {
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

  double calcTotal(List<Expense> expenses) {
    double total = 0;
    for (Expense expense in expenses) {
      total += expense.price;
    }
    return total;
  }

  // * may move out of this provider
  String totalString(List<Expense> expenses) {
    return '${calcTotal(expenses).toStringAsFixed(2)} \$';
  }
}
