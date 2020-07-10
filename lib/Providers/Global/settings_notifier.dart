import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsNotifier with ChangeNotifier {
  ThemeData _themeData;
  TimeOfDay _localNotifTime;
  String _lastUsedAccountId;

  SettingsNotifier(this._themeData, this._localNotifTime, this._lastUsedAccountId);

  ThemeData getTheme() => _themeData;
  TimeOfDay getLocalNotifTime() => _localNotifTime;
  String getLastUsedAccountId() => _lastUsedAccountId;

  Future<void> setTheme(ThemeData themeData, bool isDarkModeOn) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', isDarkModeOn);
    _themeData = themeData;
    notifyListeners();
  }

  Future<void> setLocalNotifTime(TimeOfDay selectedTime) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('localNotificationsHour', selectedTime.hour);
    prefs.setInt('localNotificationsMinute', selectedTime.minute);
    _localNotifTime = selectedTime;
    notifyListeners();
  }

  Future<void> setLastUsedAccountId(String accountId) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('lastUsedAccountId', accountId);
    _lastUsedAccountId = accountId;
  }
}
