import 'package:auth_provider_demo/data/states/auth_providers/facebook_auth_data.dart';
import 'package:auth_provider_demo/data/states/auth_providers/github_auth_data.dart';
import 'package:auth_provider_demo/widgets/buttons/action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GithubAuthScreen extends StatefulWidget {
  const GithubAuthScreen({Key? key}) : super(key: key);

  @override
  State<GithubAuthScreen> createState() => _GithubAuthScreenState();
}

class _GithubAuthScreenState extends State<GithubAuthScreen> {
  late GithubAuthData githubAuthData;

  @override
  void initState() {
    super.initState();
    // Provider.of<GithubAuthData>(context, listen: false).initDeepLinkListener();
    githubAuthData = Provider.of<GithubAuthData>(context, listen: false)
      ..initDeepLinkListener();
  }

  @override
  void dispose() {
    githubAuthData.disposeDeepLinkListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 65,
          child: Consumer<GithubAuthData>(
            builder: (context, githubAuthData, _) => ActionButton(
              text: "Github Sign In",
              isBusy: githubAuthData.isBusy,
              onPressed: () => githubAuthData.signIn(),
            ),
          ),
        ),
      ),
    );
  }
}
