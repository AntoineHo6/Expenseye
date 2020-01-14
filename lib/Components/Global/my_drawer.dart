import 'package:Expenseye/Providers/Global/expense_model.dart';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
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
              decoration: BoxDecoration(
                color: MyColors.black02dp,
              ),
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
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: refactor this bs
