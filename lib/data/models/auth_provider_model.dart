import 'package:auth_provider_demo/screens/authentication/email/email_password_screen.dart';
import 'package:auth_provider_demo/screens/authentication/facebook/facebook_auth_screen.dart';
import 'package:auth_provider_demo/screens/authentication/github/github_auth_screen.dart';
import 'package:auth_provider_demo/screens/authentication/google/google_sign_in_screen.dart';
import 'package:auth_provider_demo/screens/authentication/phone/phone_number_screen.dart';
import 'package:auth_provider_demo/screens/authentication/twitter/twitter_auth_screen.dart';
import 'package:flutter/material.dart';

class AuthProviderModel {
  String name;
  String image;
  Widget landingScreen;
  AuthProviderModel({
    required this.name,
    required this.image,
    required this.landingScreen,
  });
}

AuthProviderModel emailProvider = AuthProviderModel(
  name: "Email/Password",
  landingScreen: EmailPasswordScreen(),
  image:
      "https://static.vecteezy.com/system/resources/thumbnails/002/293/604/small/mail-icon-with-long-shadow-black-on-white-background-simple-design-style-illustration-free-vector.jpg",
);

AuthProviderModel phoneAuthProvider = AuthProviderModel(
  name: "Phone Auth",
  landingScreen: PhoneNumberScreen(),
  image: "https://static.thenounproject.com/png/118681-200.png",
);

AuthProviderModel googleAuthProvider = AuthProviderModel(
  name: "Google Auth",
  landingScreen: GoogleSignInScreen(),
  image:
      "https://cdn.icon-icons.com/icons2/800/PNG/512/_google_icon-icons.com_65791.png",
);

AuthProviderModel facebookAuthProvider = AuthProviderModel(
  name: "Facebook Auth",
  landingScreen: FacebookAuthScreen(),
  image:
      "https://cdn3.iconfinder.com/data/icons/picons-social/57/46-facebook-512.png",
);

AuthProviderModel githubAuthProvider = AuthProviderModel(
  name: "Github Auth",
  landingScreen: GithubAuthScreen(),
  image:
      "https://github.githubassets.com/images/modules/logos_page/Octocat.png",
);

AuthProviderModel twitterAuthProvider = AuthProviderModel(
  name: "Twitter Auth",
  landingScreen: TwitterAuthScreen(),
  image:
      "https://static01.nyt.com/images/2014/08/10/magazine/10wmt/10wmt-superJumbo-v4.jpg",
);

final List<AuthProviderModel> availableProviders = [
  emailProvider,
  phoneAuthProvider,
  googleAuthProvider,
  facebookAuthProvider,
  githubAuthProvider,
  twitterAuthProvider,
];
