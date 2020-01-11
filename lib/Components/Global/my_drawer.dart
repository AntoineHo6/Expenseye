import 'package:expense_app/Pages/Daily/daily_home_page.dart';
import 'package:expense_app/Pages/Monthly/monthly_home_page.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {

  const MyDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: MyColors.black00dp,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    Icon(Icons.remove_red_eye, color: Colors.white),
                    Text(
                      Strings.appName,
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: MyColors.black02dp,
              ),
            ),
            Theme(
              data: ThemeData(
                textTheme: Theme.of(context).textTheme,
                unselectedWidgetColor: Colors.white,
                accentColor: MyColors.secondary,
              ),
              child: ExpansionTile(
                title: Text(Strings.viewBy),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '\t\t\t${Strings.daily}',
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    onTap: () => _openDailyHomePage(context),
                  ),
                  ListTile(
                    title: Text(
                      '\t\t\t${Strings.monthly}',
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    onTap: () => _openMonthlyHomePage(context),
                  ),
                  ListTile(
                    title: Text(
                      '\t\t\t${Strings.yearly}',
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ),
                ],
              ),
            ),
            // ListTile(
            //   title: Text(
            //     Strings.categories,
            //     style: Theme.of(context).textTheme.subtitle,
            //   ),
            //   onTap: () {
            //     // Update the state of the app
            //     // ...
            //     // Then close the drawer
            //     Navigator.pop(context);
            //   },
            // ),
            ListTile(
              title: Text(
                Strings.settings,
                style: Theme.of(context).textTheme.subtitle,
              ),
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

  void _openMonthlyHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MonthlyHomePage()),
    );
  }
}
