import 'package:auth_provider_demo/screens/auth_state_builder.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth_provider_demo/data/models/app_user.dart';
import 'package:auth_provider_demo/data/services/auth_service.dart';
import 'package:auth_provider_demo/utils/custom_exception.dart';
import 'package:auth_provider_demo/utils/utils.dart';

import '../auth_data.dart';

class EmailPasswordAuthData extends AuthData {
  signInUsingEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Set is busy to true to prevent loading
      setBusy();

      await authService.signIn(email: email, password: password);

      // Remove all the previous routes and push the AuthStateBuilder
      Utils.removeAllAndPush(AuthStateBuilder());

      // Set is busy to false to prevent loading
      setFree();
    } on CustomException catch (e) {
      // Set is busy to false to prevent loading
      setFree();

      if (e.code == 'user-not-found') {
        Utils.errorSnackbar("No user found, Try signing up instead!");
        return;
      }

      Utils.errorSnackbar(e.message);
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
      User _user = await authService.signUp(email: email, password: password);

      // Create an AppUser object
      AppUser _appUser = AppUser(
        uid: _user.uid,
        name: name,
        email: email,
      );

      // Register on firestore
      await authService.registerUserDetails(appUser: _appUser);

      // Remove all the previous routes and push the AuthStateBuilder
      Utils.removeAllAndPush(AuthStateBuilder());

      // Set is busy to false to prevent loading
      setFree();
    } on CustomException catch (e) {
      Utils.errorSnackbar(e.message);
      setFree();
    }
  }
}
