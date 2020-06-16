import 'package:Expenseye/Providers/Global/settings_notifier.dart';
import 'package:Expenseye/Resources/Themes/my_theme_data.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsNotifier = Provider.of<SettingsNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('settings')),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(15),
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
                    value: settingsNotifier.getTheme() == MyThemeData.darkTheme
                        ? true
                        : false,
                    onChanged: (newValue) async =>
                        await _onThemeChanged(newValue, settingsNotifier),
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).translate('reminderNotification'),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        '${settingsNotifier.getLocalNotifTime().format(context)}',
                      ),
                    ],
                  ),
                  RaisedButton(
                    child: Icon(Icons.edit),
                    onPressed: () async =>
                        await _showTimePicker(context, settingsNotifier),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onThemeChanged(bool value, SettingsNotifier settingsNotifier) async {
    (value)
        ? settingsNotifier.setTheme(MyThemeData.darkTheme)
        : settingsNotifier.setTheme(MyThemeData.lightTheme);
    // tODO: put setBool in notifier
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }

  Future<void> _showTimePicker(
      BuildContext context, SettingsNotifier settingsNotifier) async {
    await showTimePicker(
      context: context,
      initialTime: settingsNotifier.getLocalNotifTime(),
    ).then(
      (selectedTime) async {
        if (selectedTime != null) {
          settingsNotifier.setLocalNotifTime(selectedTime);
          var prefs = await SharedPreferences.getInstance();
          prefs.setInt('localNotificationsHour', selectedTime.hour);
          prefs.setInt('localNotificationsMinute', selectedTime.minute);
        }
      },
    );
  }
}
