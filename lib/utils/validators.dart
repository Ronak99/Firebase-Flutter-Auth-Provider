class Validators {
  static String? validateEmail(String? name) {
    if (name!.trim().isEmpty) {
      return "Field cannot be empty";
    }

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(name)) {
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

  static String? validatePhoneNumber(String? password) {
    if (password!.trim().isEmpty) {
      return "Please provide a phone number";
    }

    if (password.length < 13) {
      return "Invalid Phone number";
    }

    return null;
  }

  static String? validateOtp(String? password) {
    if (password!.trim().isEmpty) {
      return "Please provide an OTP";
    }

    if (password.length == 6) {
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
