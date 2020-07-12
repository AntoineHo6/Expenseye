import 'package:Expenseye/Components/Global/load_dialog.dart';
import 'package:Expenseye/Providers/Global/db_notifier.dart';
import 'package:Expenseye/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class MyDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  const Icon(MdiIcons.eyeCircleOutline),
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
                      onPressed: () async => await _loadLogoutReset(context),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('signInToAvoidLosingData'),
                      style: TextStyle(
                        color: Theme.of(context).errorColor,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.person),
                          radius: 25,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          padding: const EdgeInsets.all(0),
                          child: Image.asset(
                            'assets/btn_google_img.png',
                            width: 160,
                          ),
                          onPressed: () async => await _loadLoginInit(context),
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

  Future<void> _loadLogoutReset(BuildContext context) async {
    _showLoadDialog(context);
    await Provider.of<DbNotifier>(context, listen: false).logOutFromGoogle().then(
          (value) => Navigator.pop(context),
        );
  }

  Future<void> _loadLoginInit(BuildContext context) async {
    _showLoadDialog(context);
    await Provider.of<DbNotifier>(context, listen: false).loginInit().then(
          (value) => Navigator.pop(context),
        );
  }

  void _showLoadDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoadDialog();
      },
    );
  }
}
