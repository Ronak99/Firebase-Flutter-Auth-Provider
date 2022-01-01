import 'package:auth_provider_demo/data/states/auth_data.dart';
import 'package:auth_provider_demo/screens/provider_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthData()),
      ],
      child: MaterialApp(
        builder: OneContext().builder,
        navigatorKey: OneContext().key,
        home: ProviderSelectionScreen(),
      ),
    );
  }
}
