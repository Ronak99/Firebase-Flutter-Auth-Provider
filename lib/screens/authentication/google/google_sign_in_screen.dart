import 'package:auth_provider_demo/data/states/auth_data.dart';
import 'package:auth_provider_demo/data/states/auth_providers/google_auth_data.dart';
import 'package:auth_provider_demo/widgets/buttons/action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoogleSignInScreen extends StatelessWidget {
  const GoogleSignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 65,
          child: Consumer<GoogleAuthData>(
            builder: (context, googleAuthData, _) => ActionButton(
              text: "Google Sign In",
              isBusy: googleAuthData.isBusy,
              onPressed: () => googleAuthData.signIn(),
            ),
          ),
        ),
      ),
    );
  }
}
