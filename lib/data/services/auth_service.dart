import 'package:auth_provider_demo/utils/custom_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Returns the current [User] if they are currently signed-in, or null if not.
  User? get getCurrentUser => _auth.currentUser;

  /// Notifies about changes to the user's sign-in state (such as sign-in or sign-out).
  Stream<User?> authChanges() => _auth.authStateChanges();

  Future<User> signUp({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential _userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (_userCredential.user != null) {
        return _userCredential.user!;
      }

      throw CustomException("User was null");
    } on FirebaseException catch (err) {
      throw CustomException(err.message!);
    }
  }

  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (_userCredential.user != null) return _userCredential.user!;

      throw CustomException("User was null");
    } on FirebaseException catch (err) {
      throw CustomException(err.message!, code: err.code);
    }
  }

  signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (err) {
      throw CustomException("Error in logging out : ${err.message!}");
    }
  }
}
