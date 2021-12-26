import 'package:auth_provider_demo/data/services/auth_service.dart';
import 'package:auth_provider_demo/screens/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:auth_provider_demo/data/models/auth_provider_model.dart';
import 'package:auth_provider_demo/data/states/auth_providers/email_password_auth_data.dart';
import 'package:auth_provider_demo/utils/utils.dart';
import 'package:auth_provider_demo/utils/validators.dart';
import 'package:auth_provider_demo/widgets/buttons/action_button.dart';

class EmailPasswordScreen extends StatefulWidget {
  const EmailPasswordScreen({Key? key}) : super(key: key);

  @override
  State<EmailPasswordScreen> createState() => _EmailPasswordScreenState();
}

class _EmailPasswordScreenState extends State<EmailPasswordScreen> {
  bool _showSignInView = true;

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
              "Email/Password",
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(height: 10),
            AnimatedCrossFade(
              firstChild: SignInView(
                onSignUpTap: () {
                  setState(() {
                    _showSignInView = false;
                  });
                },
              ),
              secondChild: SignUpView(
                onSignInTap: () {
                  setState(() {
                    _showSignInView = true;
                  });
                },
              ),
              crossFadeState: _showSignInView
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 250),
            ),
          ],
        ),
      ),
    );
  }
}

class SignInView extends StatefulWidget {
  final VoidCallback onSignUpTap;

  const SignInView({
    Key? key,
    required this.onSignUpTap,
  }) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _email;
  late String _password;

  _onActionButtonTap() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    EmailPasswordAuthData _emailPasswordAuthData =
        Provider.of<EmailPasswordAuthData>(context, listen: false);

    _emailPasswordAuthData.signInUsingEmailAndPassword(
      email: _email,
      password: _password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: Validators.validateEmail,
            onSaved: (value) {
              setState(() {
                _email = value!;
              });
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "email@provider.com",
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            validator: Validators.validatePassword,
            obscureText: true,
            onSaved: (value) {
              setState(() {
                _password = value!;
              });
            },
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "password",
            ),
          ),
          SizedBox(height: 10),
          Consumer<EmailPasswordAuthData>(
            builder: (context, emailPasswordAuthData, _) {
              return ActionButton(
                text: "Sign In",
                isBusy: emailPasswordAuthData.isBusy,
                onPressed: _onActionButtonTap,
              );
            },
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: widget.onSignUpTap,
            child: Text("Create New Account"),
          )
        ],
      ),
    );
  }
}

class SignUpView extends StatefulWidget {
  final VoidCallback onSignInTap;

  const SignUpView({
    Key? key,
    required this.onSignInTap,
  }) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _email;
  late String _password;
  late String _name;

  _onActionButtonTap() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    EmailPasswordAuthData _emailPasswordAuthData =
        Provider.of<EmailPasswordAuthData>(context, listen: false);

    _emailPasswordAuthData.signUpUsingEmailAndPassword(
      name: _name,
      email: _email,
      password: _password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: Validators.validateEmail,
            onSaved: (value) {
              setState(() {
                _email = value!;
              });
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "email@provider.com",
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            validator: Validators.validateSimpleString,
            onSaved: (value) {
              setState(() {
                _name = value!;
              });
            },
            decoration: InputDecoration(
              labelText: "Name",
              hintText: "Your name",
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            validator: Validators.validatePassword,
            obscureText: true,
            onSaved: (value) {
              setState(() {
                _password = value!;
              });
            },
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "password",
            ),
          ),
          SizedBox(height: 10),
          Consumer<EmailPasswordAuthData>(
            builder: (context, emailPasswordAuthData, _) {
              return ActionButton(
                text: "Sign Up",
                isBusy: emailPasswordAuthData.isBusy,
                onPressed: _onActionButtonTap,
              );
            },
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: widget.onSignInTap,
            child: Text("Sign In"),
          )
        ],
      ),
    );
  }
}
