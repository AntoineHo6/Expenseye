import 'package:Expenseye/Helpers/google_firebase_helper.dart';
import 'package:flutter/material.dart';

class FirebaseModel extends ChangeNotifier {

  FirebaseModel() {
    initConnectedUser();
  }

  void initConnectedUser() async {
    await GoogleFirebaseHelper.initConnectedUser();
  }

  Future<bool> loginWithGoogle() async {
    return await GoogleFirebaseHelper.loginWithGoogle();
  }

  Future<void> logOutFromGoogle() async {
    await GoogleFirebaseHelper.uploadDbFile();
    await GoogleFirebaseHelper.logOut();
    //await dbHelper.deleteAll();
    notifyListeners();
  }
}
