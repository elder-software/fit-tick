import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Failed to sign in anonymously: ${e.message}');
      return null;
    }
  }

  Future<UserCredential?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Failed to sign up: ${e.message}');
      return null;
    }
  }

  Future<UserCredential?> logInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Failed to log in: ${e.message}');
      return null;
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Failed to log out: ${e.toString()}');
    }
  }
}
