import 'package:auth_provider_demo/screens/authentication/email/email_password_screen.dart';
import 'package:auth_provider_demo/screens/authentication/google/google_sign_in_screen.dart';
import 'package:auth_provider_demo/screens/authentication/phone/phone_number_screen.dart';
import 'package:flutter/material.dart';

class AuthProviderModel {
  String id;
  String name;
  String image;
  Widget landing;
  AuthProviderModel({
    required this.id,
    required this.name,
    required this.image,
    required this.landing,
  });
}

AuthProviderModel emailProvider = AuthProviderModel(
  id: "email_password",
  name: "Email/Password",
  landing: EmailPasswordScreen(),
  image:
      "https://static.vecteezy.com/system/resources/thumbnails/002/293/604/small/mail-icon-with-long-shadow-black-on-white-background-simple-design-style-illustration-free-vector.jpg",
);

AuthProviderModel phoneAuthProvider = AuthProviderModel(
  id: "phone_auth",
  name: "Phone Auth",
  landing: PhoneNumberScreen(),
  image: "https://static.thenounproject.com/png/118681-200.png",
);

AuthProviderModel googleAuthProvider = AuthProviderModel(
  id: "google_auth",
  name: "Google Auth",
  landing: GoogleSignInScreen(),
  image:
      "https://cdn.icon-icons.com/icons2/800/PNG/512/_google_icon-icons.com_65791.png",
);

final List<AuthProviderModel> availableProviders = [
  emailProvider,
  phoneAuthProvider,
  googleAuthProvider,
];
