import 'package:Expenseye/Helpers/database_helper.dart';
import 'package:Expenseye/Pages/daily_page.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Providers/Global/transac_model.dart';
import 'package:Expenseye/Providers/Global/settings_notifier.dart';
import 'package:Expenseye/Resources/Themes/my_theme_data.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool darkModeOn;
  int localNotifHour;
  int localNotifMinute;
  String lastUsedAccountId;
  await SharedPreferences.getInstance().then((prefs) async {
    darkModeOn = prefs.getBool('darkMode') ?? true;
    localNotifHour = prefs.getInt('localNotificationsHour') ?? 12;
    localNotifMinute = prefs.getInt('localNotificationsMinute') ?? 0;
    lastUsedAccountId = prefs.getString('lastUsedAccountId') ??
        await DatabaseHelper.instance.queryFirstAccount().then((account) => account.id);
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<DbModel>(create: (_) => DbModel()),
          ChangeNotifierProvider<TransacModel>(create: (_) => TransacModel()),
          ChangeNotifierProvider<SettingsNotifier>(
            create: (_) => SettingsNotifier(
              darkModeOn ? MyThemeData.darkTheme : MyThemeData.lightTheme,
              TimeOfDay(hour: localNotifHour, minute: localNotifMinute),
              lastUsedAccountId,
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
      debugShowCheckedModeBanner: false,
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
        DatabaseHelper.instance.languageCode = supportedLocales.first.languageCode;
        return supportedLocales.first;
      },
      home: DailyPage(),
      theme: settingsNotifier.getTheme(),
    );
  }

  Future onDidReceiveLocalNotification(
    int id,
    String title,
    String body,
    String payload,
  ) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DailyPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DailyPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings =
        InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }
}
