import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Pages/Daily/daily_home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return ChangeNotifierProvider(
      create: (_) => new ExpenseModel(),
      child: MaterialApp(
        home: DailyHomePage(),
        theme: ThemeData(
          primaryColor: MyColors.black02dp,
          accentColor: MyColors.black02dp,
          backgroundColor: MyColors.black00dp,
          dialogBackgroundColor: MyColors.black00dp,
          scaffoldBackgroundColor: MyColors.black00dp,
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
      ),
    );
  }
}
