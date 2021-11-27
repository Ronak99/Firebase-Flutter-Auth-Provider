import 'dart:async';

import 'package:auth_provider_demo/data/states/auth_data.dart';
import 'package:auth_provider_demo/screens/auth_state_builder.dart';
import 'package:auth_provider_demo/utils/custom_exception.dart';
import 'package:auth_provider_demo/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_links/uni_links.dart';

class GithubAuthData extends AuthData {
  StreamSubscription? _subs;

  void initDeepLinkListener() {
    print("listening to subscription");
    _subs = linkStream.listen((String? link) {
      print("Event from link stream : $link");
      _checkDeepLink(link);
    }, cancelOnError: true);
  }

  void _checkDeepLink(String? link) async {
    if (link == null) {
      Utils.errorSnackbar("Deeplink was null");
      return;
    }

    String code = link.substring(link.indexOf(RegExp('code=')) + 5);

    try {
      await authService.signInWithGitHub(code);
      Utils.removeAllAndPush(AuthStateBuilder());
      setFree();
    } on CustomException catch (e) {
      setFree();
      Utils.errorSnackbar(e.message);
    }
  }

  void disposeDeepLinkListener() {
    _subs?.cancel();
  }

  signIn() async {
    setBusy();
    try {
      const String url = "https://github.com/login/oauth/authorize" +
          "?client_id=3aa8667dfbc084dcc585&scope=public_repo%20read:user%20user:email";

      if (await canLaunch(url)) {
        setBusy();
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
        );
      } else {
        setFree();
        throw CustomException("Cannot launch!");
      }
    } on CustomException catch (e) {
      Utils.errorSnackbar(e.message);
    }
  }
}
