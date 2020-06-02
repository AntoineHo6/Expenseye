import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Pages/daily_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Resources/Themes/MyColors.dart';
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
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              DatabaseHelper.instance.languageCode = locale.languageCode;
              return supportedLocale;
            }
          }
          DatabaseHelper.instance.languageCode =
              supportedLocales.first.languageCode;
          return supportedLocales.first;
        },
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
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 32, color: Colors.white),
            headline2: TextStyle(color: Colors.white),
            headline3: TextStyle(color: Colors.white),
            headline4: TextStyle(color: Colors.white),
            headline5: TextStyle(color: Colors.white),
            headline6: TextStyle(color: Colors.white),
            subtitle1: TextStyle(color: Colors.white),
            subtitle2: TextStyle(color: Colors.white),
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
            caption: TextStyle(color: Colors.white),
            button: TextStyle(color: Colors.white),
            overline: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
