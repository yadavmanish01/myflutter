import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> googleSignIn() async {
    final GoogleSignIn signIn = GoogleSignIn.instance;

    await signIn.initialize(
      serverClientId:
      '629589379314-q6g36dnrvflpgf93urs3lk52to0dmj5e.apps.googleusercontent.com',
    );

    final GoogleSignInAccount account = await signIn.authenticate();

    final GoogleSignInAuthentication googleAuth =
        account.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await auth.signInWithCredential(credential);
  }

  Future<void> googleLogout() async {
    await GoogleSignIn.instance.signOut();
    await auth.signOut();
  }
}