import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<void> login() async {
    try {
      await _googleSignIn.initialize();
      final GoogleSignInAccount? usuarioGoogle = await _googleSignIn.authenticate();
      if (usuarioGoogle != null) {
        final GoogleSignInAuthentication googleAuth = await usuarioGoogle.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
      }
    } catch (ex) {
      print("ERROR EN LOGIN: $ex");
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (ex) {
      print("ERROR EN LOGOUT: $ex");
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
