import 'package:expense_app/Components/EditAdd/add_expense_dialog.dart';
import 'package:expense_app/Models/Expense.dart';
import 'package:expense_app/Pages/EditAdd/edit_expense_page.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Utils/database_helper.dart';
import 'package:expense_app/google_auth.dart';
import 'package:flutter/material.dart';

// rename to localDbModel
class ExpenseModel extends ChangeNotifier {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final GoogleAuthService googleAuth = GoogleAuthService();

  void loginWithGoogle() async {
    await googleAuth.loginWithGoogle().then((_) {
      notifyListeners();
    });
  }

  void logOutFromGoogle() {
    dbHelper.deleteAll();
    googleAuth.logOut();
    notifyListeners();
  }

  void addExpense(Expense newExpense) {
    dbHelper.insert(newExpense);
    GoogleAuthService.uploadDbFile();
    notifyListeners();
  }

  void editExpense(Expense newExpense) {
    dbHelper.update(newExpense);
    GoogleAuthService.uploadDbFile();
    notifyListeners();
  }

  void deleteExpense(int id) {
    dbHelper.delete(id);
    GoogleAuthService.uploadDbFile();
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
    return '${calcTotal(expenses).toString()} \$';
  }

}
