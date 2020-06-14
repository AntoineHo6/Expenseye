import 'package:Expenseye/Providers/Global/theme_notifier.dart';
import 'package:Expenseye/Resources/Themes/my_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        // TODO: change to appLocalization
        children: <Widget>[
          RaisedButton(
            onPressed: () => themeNotifier.setTheme(MyThemeData.darkTheme),
            child: Text('dark'),
          ),
          RaisedButton(
            onPressed: () => themeNotifier.setTheme(MyThemeData.lightTheme),
            child: Text('light'),
          ),
        ],
      ),
    );
  }
}
