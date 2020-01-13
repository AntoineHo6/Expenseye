import 'package:expense_app/Pages/Daily/daily_home_page.dart';
import 'package:expense_app/Pages/Monthly/monthly_home_page.dart';
import 'package:expense_app/Pages/Yearly/yearly_home_page.dart';
import 'package:expense_app/Providers/Global/expense_model.dart';
import 'package:expense_app/Resources/Strings.dart';
import 'package:expense_app/Resources/Themes/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final _expenseModel = Provider.of<ExpenseModel>(context);

    return Drawer(
      child: Container(
        color: MyColors.black00dp,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
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
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseAuth.instance.onAuthStateChanged,
                      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(snapshot.data.photoUrl),
                                radius: 25,
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              RaisedButton(
                                color: MyColors.black06dp,
                                child: Text(
                                  Strings.signOut,
                                  style: Theme.of(context).textTheme.body1,
                                ),
                                onPressed: () =>
                                    _expenseModel.logOutFromGoogle(),
                              ),
                            ],
                          );
                        } else {
                          return Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.person),
                                radius: 25,
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              RaisedButton(
                                color: MyColors.black06dp,
                                child: Text(
                                  Strings.signIn,
                                  style: Theme.of(context).textTheme.body1,
                                ),
                                onPressed: () =>
                                    _expenseModel.loginWithGoogle(),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
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
                    onTap: () => _openYearlyHomePage(context),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                '${Strings.settings} (Unavailable)',
                style: Theme.of(context).textTheme.subtitle,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openDailyHomePage(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DailyHomePage()),
    );
  }

  void _openMonthlyHomePage(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MonthlyHomePage(DateTime.now())),
    );
  }

  void _openYearlyHomePage(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => YearlyHomePage()),
    );
  }
}

// TODO: refactor this bs
