class Validators {
  static String? validateEmail(String? email) {
    if (email!.trim().isEmpty) {
      return "Field cannot be empty";
    }

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return "Invalid Email";
    }

    return null;
  }
  
  static String? validatePassword(String? password) {
    if (password!.trim().isEmpty) {
      return "Please provide a password";
    }

    if (password.length < 6) {
      return "Your password is too short";
    }

    return null;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber!.trim().isEmpty) {
      return "Please provide a phone number";
    }

    if (phoneNumber.length < 13) {
      return "Invalid Phone number";
    }

    return null;
  }

  static String? validateOtp(String? otp) {
    if (otp!.trim().isEmpty) {
      return "Please provide an OTP";
    }

    if (otp.length == 6) {
      return null;
    }
    return "OTP must be of 6 characters";
  }

  static String? validateSimpleString(String? value) {
    if (value!.trim().isEmpty) {
      return "Field cannot be empty";
    }

    return null;
  }
}
