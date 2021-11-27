import 'package:auth_provider_demo/data/states/auth_data.dart';
import 'package:auth_provider_demo/screens/auth_state_builder.dart';
import 'package:auth_provider_demo/utils/custom_exception.dart';
import 'package:auth_provider_demo/utils/utils.dart';

class TwitterAuthData extends AuthData {
  signIn() async {
    setBusy();
    try {
      await authService.signInWithTwitter();
      Utils.removeAllAndPush(AuthStateBuilder());
    } on CustomException catch (e) {
      Utils.errorSnackbar(e.message);
    }
    setFree();
  }
}