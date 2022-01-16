class Validators {
  static String? validateEmail(String? value) {
    if (value!.trim().isEmpty) {
      return "Field cannot be empty";
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Invalid Email";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.trim().isNotEmpty) {
      return "Please provide a password";
    }
    if (value.length < 6) {
      return "Your password is too short";
    }
    return null;
  }

  static String? validateSimpleString(String? value) {
    if (value!.trim().isEmpty) {
      return "Field cannot be empty";
    }
    return null;
  }
}
