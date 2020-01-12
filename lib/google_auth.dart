import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final Firestore _db = Firestore.instance;

  Future<bool> loginWithGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      GoogleSignInAccount googleAcc = await _googleSignIn.signIn();

      FirebaseUser user;
      if (googleAcc != null) {
        user =
            await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: (await googleAcc.authentication).idToken,
          accessToken: (await googleAcc.authentication).accessToken,
        ));
      }

      if (user != null) {
        print('signed in as: ' + user.email);
        return true;
      }
      return false;
    } catch (e) {
      print('error logging in with google');
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
      print('signed out');
    } catch (e) {
      print('error logging out');
    }
  }
}
