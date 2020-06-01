import 'package:Expenseye/Models/Category.dart';
import 'package:Expenseye/Models/Item.dart';
import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/Resources/Themes/Colors.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _logInFirstPress = true;
    bool _logOutFirstPress = true;

    return DrawerHeader(
      decoration: BoxDecoration(
        color: MyColors.black02dp,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: <Widget>[
                  Icon(Icons.remove_red_eye, color: Colors.white),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    AppLocalizations.of(context).translate("appName"),
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data.photoUrl),
                      radius: 25,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    RaisedButton(
                      color: MyColors.black06dp,
                      child: Text(
                        AppLocalizations.of(context).translate('signOut'),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      onPressed: () {
                        if (_logOutFirstPress) {
                          _logOutFirstPress = false;
                          _logoutReset(context, _logInFirstPress);
                        }
                      },
                    ),
                  ],
                );
              } else {
                return Column(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)
                          .translate('signInToAvoidLosingData'),
                      style: TextStyle(color: Colors.red, fontSize: 11),
                    ),
                    const SizedBox(
                      height: 7,
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
                              ),
                            ],
                          ),
                          onPressed: () {
                            if (_logInFirstPress) {
                              _logInFirstPress = false;
                              _loginInit(context, _logOutFirstPress);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

Future<void> _logoutReset(BuildContext context, _logInFirstPress) async {
  await Provider.of<DbModel>(context, listen: false).logOutFromGoogle();
  _logInFirstPress = true;
}

Future<void> _loginInit(BuildContext context, _logOutFirstPress) async {
  final _dbModel = Provider.of<DbModel>(context, listen: false);
  final _firebaseModel = Provider.of<DbModel>(context, listen: false);

  List<Item> localItems = await _dbModel.queryAllItems();
  List<Category> localCategories = await _dbModel.queryCategories();

  bool isLoggedIn = await _firebaseModel.loginWithGoogle();
  await _dbModel.initUserCategoriesMap();

  List<Category> accCategories = await _dbModel.queryCategories();

  if (isLoggedIn) {
    await _dbModel.addLocalItems(localItems, localCategories, accCategories);
  }
  _logOutFirstPress = true;
}
