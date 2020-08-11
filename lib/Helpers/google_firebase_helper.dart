import 'dart:io';
import 'package:Expenseye/Resources/Strings.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';

class GoogleFirebaseHelper {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();
  static FirebaseStorage _storage = FirebaseStorage.instance;
  static FirebaseUser user;

  static Future<void> initConnectedUser() async {
    user = await _auth.currentUser();
  }

  static Future<bool> loginWithGoogle() async {
    try {
      GoogleSignInAccount googleAcc = await _googleSignIn.signIn();

      AuthResult res;
      if (googleAcc != null) {
        res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: (await googleAcc.authentication).idToken,
          accessToken: (await googleAcc.authentication).accessToken,
        ));
      }

      if (res.user != null) {
        user = res.user;
        String _storageFilePath = 'dbFiles/${user.uid}/${Strings.dbFileName}';

        // download db file
        try {
          final ref = _storage.ref().child(_storageFilePath);
          var url = await ref.getDownloadURL();

          Directory documentsDirectory = await getApplicationDocumentsDirectory();
          String path = join(documentsDirectory.path, Strings.dbFileName);

          await HttpClient()
              .getUrl(Uri.parse(url))
              .then((HttpClientRequest request) => request.close())
              .then((HttpClientResponse response) => response.pipe(new File(path).openWrite()));

          return true;
        } catch (e) {
          print('Error copying the db file from firebase storage');
          print('REEEEEEEEEEEEEEEEEEEEEEEEEEE');
          await logOut();
        }
      }
    } catch (e) {
      print('error logging in with google');
    }
    return false;
  }

  static Future<void> logOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      user = null;
    } catch (e) {
      print('error logging out');
    }
  }

  static Future<void> uploadDbFile() async {
    if (user != null) {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, Strings.dbFileName);
      File dbFile = File(path);

      StorageUploadTask uploadTask =
          _storage.ref().child('dbFiles/${user.uid}/${Strings.dbFileName}').putFile(dbFile);

      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      await storageTaskSnapshot.ref.getDownloadURL();
    }
  }
}
