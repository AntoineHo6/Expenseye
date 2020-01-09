import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Pages/Daily/daily_home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new ExpenseModel(),
      child: MaterialApp(
        home: DailyHomePage(),
        theme: ThemeData(
          primaryColor: MyColors.black02dp,
          accentColor: MyColors.black02dp,
          backgroundColor: MyColors.black00dp,
          textTheme: TextTheme(
            display1: TextStyle(color: Colors.white),
            headline: TextStyle(color: Colors.white),
            body1: TextStyle(color: Colors.white),
            subtitle: TextStyle(color: Colors.white),
            subhead: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
