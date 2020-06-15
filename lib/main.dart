import 'package:Expenseye/Components/Global/local_notification.dart';
import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Pages/daily_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Providers/Global/theme_notifier.dart';
import 'package:Expenseye/Resources/Themes/my_theme_data.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool darkModeOn;
  await SharedPreferences.getInstance().then((prefs) {
    darkModeOn = prefs.getBool('darkMode') ?? true;
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<DbModel>(create: (_) => DbModel()),
          ChangeNotifierProvider<ItemModel>(create: (_) => ItemModel()),
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => ThemeNotifier(
                darkModeOn ? MyThemeData.darkTheme : MyThemeData.lightTheme),
          ),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    if (themeNotifier.getTheme() == MyThemeData.lightTheme) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }

    return MaterialApp(
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
        // body: DailyPage(),
        body: LocalNotification(),
      ),
      theme: themeNotifier.getTheme(),
    );
  }
}
