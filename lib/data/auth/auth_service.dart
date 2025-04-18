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

  Future<UserCredential?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Failed to sign up: ${e.message}');
      return null;
    }
  }

  Future<UserCredential?> linkAnonymousAccountWithEmail(
    String email,
    String password,
  ) async {
    final user = _auth.currentUser;
    if (user == null || !user.isAnonymous) {
      if (user != null) {
        await signUpWithEmailAndPassword(email, password);
      } else {
        print('Error: Not signed in as an anonymous user.');
        throw FirebaseAuthException(
          code: 'not-anonymous',
          message: 'User must be signed in anonymously to link.',
        );
      }
    }

    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      UserCredential userCredential = await user.linkWithCredential(credential);
      print(
        'Anonymous account successfully linked with email: ${userCredential.user?.email}',
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Failed to link anonymous account: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('An unexpected error occurred during linking: ${e.toString()}');
      rethrow;
    }
  }

  Future<UserCredential?> logInWithEmailAndPassword(
    String email,
    String password,
  ) async {
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
      await signInAnonymously();
    } catch (e) {
      print('Failed to log out or sign back in anonymously: ${e.toString()}');
    }
  }

  Future<void> deleteAccount(String password) async {
    final user = _auth.currentUser;
    if (user == null) {
      print('Error: No user to delete.');
      return;
    }

    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );
    await user.reauthenticateWithCredential(credential);
    try {
      await user.delete();
      print('Account deleted successfully.');
    } on FirebaseAuthException catch (e) {
      print('Failed to delete account: ${e.message}');
    }
  }
}
