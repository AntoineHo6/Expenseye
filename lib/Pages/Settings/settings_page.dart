import 'package:Expenseye/Providers/Global/theme_notifier.dart';
import 'package:Expenseye/Resources/Themes/my_theme_data.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('settings')),
      ),
      body: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).translate('darkTheme'),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              Switch(
                value: themeNotifier.getTheme() == MyThemeData.darkTheme
                    ? true
                    : false,
                onChanged: (newValue) =>
                    onThemeChanged(newValue, themeNotifier),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(MyThemeData.darkTheme)
        : themeNotifier.setTheme(MyThemeData.lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }
}
