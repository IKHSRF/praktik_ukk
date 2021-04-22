import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<String> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'Berhasil Login';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }
}
