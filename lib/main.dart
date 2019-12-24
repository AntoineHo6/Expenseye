import 'package:expense_app_beginner/Blocs/expand_expense_bloc.dart';
import 'package:expense_app_beginner/Blocs/expense_bloc.dart';
import 'package:expense_app_beginner/Pages/today_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExpenseBloc>.value(
          value: ExpenseBloc(),
        ),
        ChangeNotifierProvider<ExpandExpenseBloc>.value(
          value: ExpandExpenseBloc(),
        ),
      ],
      child: MaterialApp(
        home: TodayPage(),
      ),
    );
  }
}
