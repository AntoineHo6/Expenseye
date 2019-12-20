import 'package:expense_app_beginner/Blocs/ExpenseBloc.dart';
import 'package:expense_app_beginner/Pages/TodayPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExpenseBloc>.value(
      value: ExpenseBloc(),
      child: MaterialApp(
        home: TodayPage(),
      )
    );
  }
}
