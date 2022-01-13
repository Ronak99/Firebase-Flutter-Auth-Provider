import 'package:auth_provider_demo/data/states/auth_data.dart';
import 'package:auth_provider_demo/data/states/auth_providers/email_password_auth_data.dart';
import 'package:auth_provider_demo/screens/auth_state_builder.dart';
import 'package:auth_provider_demo/screens/authentication/provider_selection_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';

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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthData()),
        ChangeNotifierProvider(create: (_) => EmailPasswordAuthData()),
      ],
      child: MaterialApp(
        builder: OneContext().builder,
        navigatorKey: OneContext().key,
        home: AuthStateBuilder(),
      ),
    );
  }
}
