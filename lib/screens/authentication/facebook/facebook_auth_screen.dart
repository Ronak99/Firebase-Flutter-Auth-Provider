import 'package:auth_provider_demo/data/states/auth_providers/facebook_auth_data.dart';
import 'package:auth_provider_demo/widgets/buttons/action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FacebookAuthScreen extends StatelessWidget {
  const FacebookAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 65,
          child: Consumer<FacebookAuthData>(
            builder: (context, facebookAuthData, _) => ActionButton(
              text: "Facebook Sign In",
              isBusy: facebookAuthData.isBusy,
              onPressed: () => facebookAuthData.signIn(),
            ),
          ),
        ),
      ),
    );
  }
}
