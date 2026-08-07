import 'package:firebase_auth/firebase_auth.dart';

class Resetpasswordrepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<dynamic>ForgetPasswordApi({
    required String email
})async{
    return await _auth.sendPasswordResetEmail(email: email);
  }
}