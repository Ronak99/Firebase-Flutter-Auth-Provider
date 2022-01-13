import 'package:auth_provider_demo/data/services/auth_service.dart';
import 'package:auth_provider_demo/screens/authentication/provider_selection_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'landing/landing_screen.dart';

class AuthStateBuilder extends StatelessWidget {
  const AuthStateBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LandingScreen();
        }
        return ProviderSelectionScreen();
      },
    );
  }
}
