import 'package:auth_provider_demo/data/states/auth_providers/facebook_auth_data.dart';
import 'package:auth_provider_demo/data/states/auth_providers/twitter_auth_data.dart';
import 'package:auth_provider_demo/widgets/buttons/action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TwitterAuthScreen extends StatelessWidget {
  const TwitterAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 65,
          child: Consumer<TwitterAuthData>(
            builder: (context, twitterAuthData, _) => ActionButton(
              text: "Twitter Sign In",
              isBusy: twitterAuthData.isBusy,
              onPressed: () => twitterAuthData.signIn(),
            ),
          ),
        ),
      ),
    );
  }
}
