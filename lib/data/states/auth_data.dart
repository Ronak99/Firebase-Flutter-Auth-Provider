import 'package:auth_provider_demo/data/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthData extends ChangeNotifier {
  bool _isBusy = false;
  bool get isBusy => _isBusy;

  AuthService authService = AuthService();

  setBusy() {
    _isBusy = true;
    notifyListeners();
  }

  setFree() {
    _isBusy = false;
    notifyListeners();
  }
}
