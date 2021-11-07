import 'package:auth_provider_demo/data/models/auth_provider_model.dart';
import 'package:auth_provider_demo/utils/utils.dart';
import 'package:flutter/material.dart';

class EmailPasswordScreen extends StatelessWidget {
  const EmailPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Text(
              "Email Password Signin",
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
