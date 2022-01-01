import 'package:flutter/material.dart';

class AuthData extends ChangeNotifier {
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
