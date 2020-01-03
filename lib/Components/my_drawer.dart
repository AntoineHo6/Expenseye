import 'package:expense_app_beginner/Resources/Strings.dart';
import 'package:expense_app_beginner/Resources/Themes/Colors.dart';
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
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: MyColors.indigoInk,
              ),
            ),
            ListTile(
              title: Text(Strings.todaysExpenses),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
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
}
