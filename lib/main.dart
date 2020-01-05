import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Pages/daily_page.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new ExpenseModel(),
      child: MaterialApp(
        home: DailyPage(),
        theme: ThemeData(
          primaryColor: MyColors.indigoInk,
          accentColor: MyColors.blueberry,
          backgroundColor: MyColors.periwinkle
        ),
      ),
    );
  }
}
