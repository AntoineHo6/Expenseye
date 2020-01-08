import 'package:expense_app/Pages/Daily/daily_home_page.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';

class MyDrawer extends Drawer {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: MyColors.periwinkle,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child:
              Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
                  Icon(Icons.remove_red_eye, color: Colors.white),
                  Text(
                    Strings.appName,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ],
              ),
            ),
              decoration: BoxDecoration(
                color: MyColors.indigoInk,
              ),
            ),
            ExpansionTile(
              title: Text(Strings.viewBy),
              children: <Widget>[
                // TODO: implement onTap
                ListTile(
                  title: Text(Strings.daily),
                  onTap: () => _openDailyHomePage(context),
                ),
                ListTile(
                  title: Text(Strings.weekly),
                ),
                ListTile(
                  title: Text(Strings.monthly),
                ),
                ListTile(
                  title: Text(Strings.yearly),
                ),
              ],
            ),
            ListTile(
              title: Text(Strings.categories),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Statistics'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(Strings.settings),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openDailyHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DailyHomePage()),
    );
  }
}
