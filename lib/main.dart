import 'package:Expenseye/Providers/Global/expense_model.dart';
import 'package:Expenseye/Providers/daily_model.dart';
import 'package:Expenseye/Providers/monthly_model.dart';
import 'package:Expenseye/Providers/yearly_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExpenseModel>(create: (_) => ExpenseModel()),
        ChangeNotifierProvider<DailyModel>(create: (_) => DailyModel()),
        ChangeNotifierProvider<MonthlyModel>(
            create: (_) => MonthlyModel(DateTime.now())),
        ChangeNotifierProvider<YearlyModel>(create: (_) => YearlyModel()),
      ],
      child: MaterialApp(
        home: HomePage(),
        theme: ThemeData(
          primaryColor: MyColors.black02dp,
          accentColor: MyColors.black02dp,
          backgroundColor: MyColors.black00dp,
          dialogBackgroundColor: MyColors.black00dp,
          scaffoldBackgroundColor: MyColors.black00dp,
          buttonColor: MyColors.black02dp,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: MyColors.secondary,
          ),
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
      ),
    );
  }
}
