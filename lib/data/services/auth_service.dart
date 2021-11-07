import 'package:auth_provider_demo/data/models/app_user.dart';
import 'package:auth_provider_demo/utils/custom_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;

  /// Returns the current [User] if they are currently signed-in, or null if not.
  User? getCurrentUser() => _auth.currentUser;

  /// Notifies about changes to the user's sign-in state (such as sign-in or sign-out).
  Stream<User?> authChanges() => _auth.authStateChanges();

  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
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

  Future<bool> registerUserDetails({required AppUser appUser}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(appUser.uid)
          .set(appUser.toMap());
      return true;
    } on FirebaseException catch (err) {
      throw CustomException(err.message!);
    }
  }

  Future<User> signInWithAuthCredential({
    required AuthCredential authCredential,
  }) async {
    try {
      UserCredential _userCredential =
          await _auth.signInWithCredential(authCredential);

      if (_userCredential.user != null) {
        return _userCredential.user!;
      }

      throw CustomException("User was null");
    } on FirebaseAuthException catch (err) {
      throw CustomException(err.message!);
    }
  }

  static Future<AuthCredential> _getGoogleAuthCredential() async {
    try {
      GoogleSignInAccount? _signInAccount = await _googleSignIn.signIn();
      if (_signInAccount == null) {
        throw CustomException("An error occurred while signing in");
      }

      GoogleSignInAuthentication _signInAuthentication =
          await _signInAccount.authentication;

      final AuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: _signInAuthentication.accessToken,
        idToken: _signInAuthentication.idToken,
      );

      return googleAuthCredential;
    } catch (e) {
      throw CustomException("An error occurred while signing in");
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      AuthCredential _googleAuthCredential = await _getGoogleAuthCredential();
      return await signInWithAuthCredential(authCredential: _googleAuthCredential);
    } on CustomException catch (err) {
      throw CustomException(err.message);
    }
  }

  /// Sends OTP to the provided phone number
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(String, int?) codeSent,
  }) {
    try {
      return FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: (FirebaseAuthException authException) {
          if (authException.code == 'invalid-phone-number') {
            throw CustomException("Invalid Phone Number");
          } else if (authException.code == 'too-many-requests') {
            throw CustomException("Too Many Requests");
          } else {
            throw CustomException(authException.message ?? "Null message");
          }
        },
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(seconds: 120),
      );
    } on FirebaseException catch (err) {
      throw CustomException(err.message!);
    }
  }

  signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (err) {
      throw CustomException(err.code);
    }
  }
}