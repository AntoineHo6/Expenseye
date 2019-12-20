import 'package:expense_app_beginner/TodayModel.dart';
import 'package:expense_app_beginner/TodayPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodayModel>.value(
      value: TodayModel(),
      child: MaterialApp(
        home: TodayPage(),
      )
    );
  }
}
