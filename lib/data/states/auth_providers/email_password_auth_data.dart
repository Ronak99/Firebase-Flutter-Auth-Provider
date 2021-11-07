import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth_provider_demo/data/models/app_user.dart';
import 'package:auth_provider_demo/data/services/auth_service.dart';
import 'package:auth_provider_demo/utils/custom_exception.dart';
import 'package:auth_provider_demo/utils/utils.dart';

import '../auth_data.dart';

class EmailPasswordAuthData extends AuthData {
  final AuthService _authService = AuthService();

  signInUsingEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Set is busy to true to prevent loading
      setBusy();

      await _authService.signIn(email: email, password: password);

      // Set is busy to false to prevent loading
      setFree();
    } on CustomException catch (e) {
      Utils.errorSnackbar(e.message);

      // Set is busy to false to prevent loading
      setFree();
    }
  }

  signUpUsingEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      setBusy();

      // Sign up the user
      User _user = await _authService.signUp(email: email, password: password);

      // Create an AppUser object
      AppUser _appUser = AppUser(
        uid: _user.uid,
        name: name,
        email: email,
      );

      // Register on firestore
      await _authService.registerUserDetails(appUser: _appUser);

      // Set is busy to false to prevent loading
      setFree();
    } on CustomException catch (e) {
      Utils.errorSnackbar(e.message);
      setFree();
    }
  }
}
