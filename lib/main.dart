import 'package:expense_app_beginner/ChangeNotifiers/Global/expense_model.dart';
import 'package:expense_app_beginner/Pages/today_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new ExpenseModel(),
      child: MaterialApp(
        home: TodayPage(),
        theme: ThemeData(
          textTheme: TextTheme(
            // TODO: add custom fonts and shit
          ),
        ),
      ),
    );
  }
}

/**
 * TODO: types of expenses. Allow user to create their own type of expense.
 * 
 * TODO: Create settings
 * 
 * TODO: Create stats page
 * 
 * TODO: Create calendar page
 */

