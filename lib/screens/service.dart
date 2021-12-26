import 'package:flutter/services.dart';

class YahooAuthService {
  var _methodChannel = MethodChannel("com.example.authproviderdemo/yahooauth");

  Future<String> initiateYahooAuthentication() async =>
      await _methodChannel.invokeMethod("yahooAuth");
}
