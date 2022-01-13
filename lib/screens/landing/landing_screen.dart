import 'package:auth_provider_demo/data/services/auth_service.dart';
import 'package:auth_provider_demo/utils/custom_exception.dart';
import 'package:auth_provider_demo/utils/utils.dart';
import 'package:auth_provider_demo/widgets/buttons/action_button.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButton(
              text: "Logout",
              onPressed: () async {
                try {
                  await AuthService().signOut();
                  Utils.successSnackbar("Logged Out");
                } on CustomException catch (e) {
                  Utils.errorSnackbar(e.message);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
