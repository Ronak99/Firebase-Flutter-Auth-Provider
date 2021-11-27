import 'package:auth_provider_demo/screens/auth_state_builder.dart';
import 'package:auth_provider_demo/screens/authentication/phone/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth_provider_demo/data/services/auth_service.dart';
import 'package:auth_provider_demo/utils/custom_exception.dart';
import 'package:auth_provider_demo/utils/utils.dart';

import '../auth_data.dart';

class PhoneAuthData extends AuthData {
  String? _verificationId;

  sendOtp({required String phoneNumber}) async {
    try {
      setBusy();

      // Code responsible for sending the OTP
      authService.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
        codeSent: (verificationId, forceResend) {
          _verificationId = verificationId;
          setFree();
          Utils.navigateTo(OtpScreen());
        },
      );
    } on CustomException catch (e) {
      Utils.errorSnackbar(e.message);
      setFree();
    }
  }

  /// Should be called from the OTP Screen
  verifyOtp({
    required String otpCode,
  }) async {
    setBusy();

    if (_verificationId == null) {
      Utils.errorSnackbar("Verification id was not assigned");
      setFree();
      return;
    }

    // Create a PhoneAuthCredential with the code
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otpCode,
      );

      User _user = await authService.signInWithAuthCredential(
        authCredential: phoneAuthCredential,
      );

      // Remove all the previous routes and push the AuthStateBuilder
      Utils.removeAllAndPush(AuthStateBuilder());

      setFree();
    } on CustomException catch (e) {
      Utils.errorSnackbar(e.message);
      setFree();
    }
  }

  _signInOnPhone() {}

  _signInOnWeb() {
    // FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber);
  }
}
