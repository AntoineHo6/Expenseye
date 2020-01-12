import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignInAccount googleAcc;

  Future<bool> loginWithGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      googleAcc = await _googleSignIn.signIn();

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

  uploadFileToGoogleDrive() async {
    if (googleAcc != null) {
      var client = GoogleHttpClient(await googleAcc.authHeaders);
      var drive = DriveApi(client);
      File fileToUpload = File();
      var file = await FilePicker.getFile();
      fileToUpload.parents = ["appDataFolder"];
      fileToUpload.name = 'testing google drive upload';
      var response = await drive.files.create(
        fileToUpload,
        uploadMedia: Media(file.openRead(), file.lengthSync()),
      );
      print(response);
    }
  }
}

class GoogleHttpClient extends IOClient {
  Map<String, String> _headers;
  GoogleHttpClient(this._headers) : super();
  @override
  Future<StreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));
  @override
  Future<Response> head(Object url, {Map<String, String> headers}) =>
      super.head(url, headers: headers..addAll(_headers));
}
