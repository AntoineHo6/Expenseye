import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';

class GoogleAuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();
  static FirebaseStorage _storage = FirebaseStorage.instance;
  static FirebaseUser user;
  String _storageFilePath;

  Future<bool> loginWithGoogle() async {
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
        print('signed in as: ' + res.user.email);

        _storageFilePath = 'dbFiles/${user.uid}/MyDatabase.db';

        // copy db file
        final ref = _storage.ref().child(_storageFilePath);
        var url = await ref.getDownloadURL();

        // TODO: dup code from
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        String path = join(documentsDirectory.path, "MyDatabase.db");
        
        await HttpClient()
            .getUrl(Uri.parse(url))
            .then((HttpClientRequest request) => request.close())
            .then((HttpClientResponse response) =>
                response.pipe(new File(path).openWrite()));

        return true;
      }
      return false;
    } catch (e) {
      print('error logging in with google');
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut().then((_) {
        _googleSignIn.signOut();
        user = null;
        print('signed out');
      });
    } catch (e) {
      print('error logging out');
    }
  }

  static void uploadDbFile() async {
    if (user != null) {
      // dont find path everytime. use member var.
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, "MyDatabase.db");
      File dbFile = File(path);

      final StorageUploadTask task = _storage
          .ref()
          .child('dbFiles/${user.uid}/MyDatabase.db')
          .putFile(dbFile);

      print('uploaded file');
    }
  }
}
