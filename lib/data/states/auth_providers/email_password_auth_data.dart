import 'package:auth_provider_demo/data/services/auth_service.dart';
import 'package:auth_provider_demo/data/states/auth_data.dart';
import 'package:auth_provider_demo/screens/auth_state_builder.dart';
import 'package:auth_provider_demo/utils/custom_exception.dart';
import 'package:auth_provider_demo/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailPasswordAuthData extends AuthData {
  bool _hasSelectedSignUpView = true;
  bool get getHasSelectedSignUpView => _hasSelectedSignUpView;

  toggleAuthView() {
    _hasSelectedSignUpView = !_hasSelectedSignUpView;
    notifyListeners();
  }

  signUpUsingEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      setBusy();

      User user = await authService.signUp(email: email, password: password);

      print("Signed up user\'s uid : ${user.uid}");

      Utils.removeAllAndPush(AuthStateBuilder());

      setFree();
    } on CustomException catch (e) {
      Utils.errorSnackbar(e.message);
      setFree();
    }
  }

  signInUsingEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      setBusy();

      await authService.signIn(email: email, password: password);

      Utils.removeAllAndPush(AuthStateBuilder());

      setFree();
    } on CustomException catch (e) {
      setFree();

      if (e.code == 'user-not-found') {
        Utils.errorSnackbar("No user found, try signing up instead!");
        return;
      }

      Utils.errorSnackbar(e.message);
    }
  }
}
