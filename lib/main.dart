import 'package:auth_provider_demo/data/states/auth_providers/facebook_auth_data.dart';
import 'package:auth_provider_demo/data/states/auth_providers/google_auth_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';

import 'data/states/auth_data.dart';
import 'data/states/auth_providers/email_password_auth_data.dart';
import 'data/states/auth_providers/phone_auth_data.dart';
import 'screens/auth_state_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print(e);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthData()),
        ChangeNotifierProvider(create: (_) => EmailPasswordAuthData()),
        ChangeNotifierProvider(create: (_) => PhoneAuthData()),
        ChangeNotifierProvider(create: (_) => GoogleAuthData()),
        ChangeNotifierProvider(create: (_) => FacebookAuthData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: OneContext().builder,
        navigatorKey: OneContext().key,
        home: AuthStateBuilder(),
      ),
    );
  }
}
