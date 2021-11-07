import 'package:auth_provider_demo/data/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthData extends ChangeNotifier {
  final AuthService authService = AuthService();
  bool _isBusy = false;
  bool get isBusy => _isBusy;

  setBusy() {
    _isBusy = true;
    notifyListeners();
  }

  setFree() {
    _isBusy = false;
    notifyListeners();
  }
}
