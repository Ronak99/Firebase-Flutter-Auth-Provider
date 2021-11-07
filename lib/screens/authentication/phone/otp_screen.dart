import 'package:auth_provider_demo/data/states/auth_providers/phone_auth_data.dart';
import 'package:auth_provider_demo/utils/validators.dart';
import 'package:auth_provider_demo/widgets/buttons/action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _otpCode;

  _onVerifyButtonTap() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    PhoneAuthData _phoneAuthData =
        Provider.of<PhoneAuthData>(context, listen: false);

    _phoneAuthData.verifyOtp(otpCode: _otpCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter OTP",
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: Validators.validateOtp,
                    onSaved: (value) {
                      setState(() {
                        _otpCode = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Enter OTP",
                      hintText: "123456",
                    ),
                  ),
                  SizedBox(height: 10),
                  Consumer<PhoneAuthData>(
                    builder: (context, phoneAuthData, _) {
                      return ActionButton(
                        text: "Verify and Sign in",
                        isBusy: phoneAuthData.isBusy,
                        onPressed: _onVerifyButtonTap,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
