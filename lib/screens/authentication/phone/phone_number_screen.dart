import 'package:auth_provider_demo/data/states/auth_providers/phone_auth_data.dart';
import 'package:auth_provider_demo/utils/validators.dart';
import 'package:auth_provider_demo/widgets/buttons/action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _phoneNumber;

  _onSendOTPButtonTap() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    PhoneAuthData _phoneAuthData =
        Provider.of<PhoneAuthData>(context, listen: false);

    _phoneAuthData.sendOtp(phoneNumber: _phoneNumber);
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
              "Phone Auth",
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: Validators.validatePhoneNumber,
                    onSaved: (value) {
                      setState(() {
                        _phoneNumber = value!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Enter Phone Number",
                      hintText: "+917894561232",
                    ),
                  ),
                  SizedBox(height: 10),
                  Consumer<PhoneAuthData>(
                    builder: (context, phoneAuthData, _) {
                      return ActionButton(
                        text: "Send OTP",
                        isBusy: phoneAuthData.isBusy,
                        onPressed: _onSendOTPButtonTap,
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
