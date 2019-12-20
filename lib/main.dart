import 'package:expense_app_beginner/Blocs/TodayBloc.dart';
import 'package:expense_app_beginner/Pages/TodayPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodayBloc>.value(
      value: TodayBloc(),
      child: MaterialApp(
        home: TodayPage(),
      )
    );
  }
}
