import 'package:Expenseye/Providers/Global/db_model.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class MyDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _logInFirstPress = true;
    bool _logOutFirstPress = true;

    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: <Widget>[
                  Icon(MdiIcons.eyeCircleOutline),
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
                          child: Image.asset(
                            'assets/btn_google_img.png',
                            width: 180,
                          ),
                          onPressed: () async {
                            if (_logInFirstPress) {
                              _logInFirstPress = false;
                              await _loginInit(context, _logOutFirstPress);
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
  await Provider.of<DbModel>(context, listen: false).loginInit();
  _logOutFirstPress = true;
}
