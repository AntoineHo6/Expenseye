import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Pages/daily_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
import 'package:Expenseye/Providers/Global/settings_notifier.dart';
import 'package:Expenseye/Resources/Themes/my_theme_data.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool darkModeOn;
  int localNotifHour;
  int localNotifMinute;
  await SharedPreferences.getInstance().then((prefs) {
    darkModeOn = prefs.getBool('darkMode') ?? true;
    localNotifHour = prefs.getInt('localNotificationsHour') ?? 12;
    localNotifMinute = prefs.getInt('localNotificationsMinute') ?? 0;
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<DbModel>(create: (_) => DbModel()),
          ChangeNotifierProvider<ItemModel>(create: (_) => ItemModel()),
          ChangeNotifierProvider<SettingsNotifier>(
            create: (_) => SettingsNotifier(
              darkModeOn ? MyThemeData.darkTheme : MyThemeData.lightTheme,
              TimeOfDay(hour: localNotifHour, minute: localNotifMinute),
            ),
          ),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final settingsNotifier = Provider.of<SettingsNotifier>(context);
    if (settingsNotifier.getTheme() == MyThemeData.lightTheme) {
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
      home: DailyPage(),
      theme: settingsNotifier.getTheme(),
    );
  }
}
