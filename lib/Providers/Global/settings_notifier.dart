import 'package:flutter/material.dart';

class SettingsNotifier with ChangeNotifier {
  ThemeData _themeData;
  TimeOfDay _localNotifTime;

  SettingsNotifier(this._themeData, this._localNotifTime);

  ThemeData getTheme() => _themeData;
  TimeOfDay getLocalNotifTime() => _localNotifTime;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  setLocalNotifTime(TimeOfDay time) async {
    _localNotifTime = time;
    notifyListeners();
  }
}
