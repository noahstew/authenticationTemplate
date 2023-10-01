import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  // Creating new instance of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method registering first time users
  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Method signing in returning users
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
