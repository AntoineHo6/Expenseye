import 'package:Expenseye/Pages/daily_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ItemModel>(create: (_) => ItemModel()),
          ChangeNotifierProvider<DbModel>(create: (_) => DbModel())
        ],
        child: MaterialApp(
          supportedLocales: [Locale('en'), Locale('fr')],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate
          ],
          home: Scaffold(
            body: DailyPage(),
          ),
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
        ));
  }
}
