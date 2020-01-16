import 'package:Expenseye/Pages/about_page.dart';
import 'package:Expenseye/Providers/Global/item_model.dart';
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
    final _expenseModel = Provider.of<ItemModel>(context, listen: false);

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
                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.remove_red_eye, color: Colors.white),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            Strings.appName,
                            style: Theme.of(context).textTheme.headline,
                          ),
                        ],
                      ),
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
                          return Column(
                            children: <Widget>[
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  Strings.signInToAvoidLosingData,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
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
                                    padding: const EdgeInsets.all(0),
                                    color: MyColors.black06dp,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/btn_google_img.png',
                                          width: 180,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                    onPressed: () =>
                                        _expenseModel.loginWithGoogle(),
                                  ),
                                ],
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
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.info_outline, color: Colors.white),
                  const SizedBox(width: 6),
                  const Text(Strings.about),
                ],
              ),
              onTap: () => openAboutPage(context),
            ),
          ],
        ),
      ),
    );
  }

  void openAboutPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutPage()),
    );
  }
}

// TODO: refactor this bs
