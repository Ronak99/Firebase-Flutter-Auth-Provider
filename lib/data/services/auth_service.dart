import 'package:auth_provider_demo/data/models/app_user.dart';
import 'package:auth_provider_demo/data/models/github_login_request.dart';
import 'package:auth_provider_demo/data/models/github_login_response.dart';
import 'package:auth_provider_demo/utils/custom_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  // final FacebookAuth _facebookAuth = FacebookAuth.instance;

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
      throw CustomException(err.message!, code: err.code);
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

  Future<AuthCredential> _getGoogleAuthCredential() async {
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
      return await signInWithAuthCredential(
          authCredential: _googleAuthCredential);
    } on CustomException catch (err) {
      throw CustomException(err.message);
    }
  }

  Future<AuthCredential> _getFacebookAuthCredential() async {
    try {
      final LoginResult facebookLoginResult =
          await FacebookAuth.instance.login();

      if (facebookLoginResult.accessToken == null) {
        throw CustomException("Facebook access token was null");
      }

      switch (facebookLoginResult.status) {
        case LoginStatus.success:
          return FacebookAuthProvider.credential(
              facebookLoginResult.accessToken!.token) as FacebookAuthCredential;
        case LoginStatus.cancelled:
          throw CustomException("Process was cancelled");
        case LoginStatus.failed:
          throw CustomException("Sign In Failed");
        case LoginStatus.operationInProgress:
          throw CustomException("In Progress");
      }
    } on CustomException catch (err) {
      throw CustomException(err.message);
    }
  }

  Future<User> loginWithGitHub(String code) async {
    try {
      //ACCESS TOKEN REQUEST
      final response = await http.post(
        Uri.parse("https://github.com/login/oauth/access_token"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode(GitHubLoginRequest(
          clientId: "3aa8667dfbc084dcc585",
          clientSecret: "481e99a99164e1362d25cbb20d47529aa1c81126",
          code: code,
        )),
      );

      GitHubLoginResponse loginResponse =
          GitHubLoginResponse.fromJson(json.decode(response.body));

      //FIREBASE SIGNIN
      final AuthCredential _githubAuthCredential =
          GithubAuthProvider.credential(loginResponse.accessToken);

      return await signInWithAuthCredential(
        authCredential: _githubAuthCredential,
      );
    } on CustomException catch (err) {
      throw err;
    }
  }

  Future<User> signInWithFacebook() async {
    try {
      AuthCredential? _facebookAuthCredential =
          await _getFacebookAuthCredential();

      return await signInWithAuthCredential(
        authCredential: _facebookAuthCredential,
      );
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
