import 'package:auth_provider_demo/data/states/auth_providers/email_password_auth_data.dart';
import 'package:auth_provider_demo/widgets/buttons/action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailPasswordScreen extends StatelessWidget {
  const EmailPasswordScreen({Key? key}) : super(key: key);

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
            Consumer<EmailPasswordAuthData>(
              builder: (context, emailPasswordAuthData, _) {
                return emailPasswordAuthData.getHasSelectedSignUpView
                    ? SignUpView()
                    : SignInView();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _email;
  late String _password;
  late String _name;

  _onActionButtonTap() {
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
            onSaved: (value) {
              setState(() {
                _name = value!;
              });
            },
            decoration: InputDecoration(
              labelText: "Name",
              hintText: "Your Name",
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            onSaved: (value) {
              setState(() {
                _password = value!;
              });
            },
            obscureText: true,
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
            onTap: () =>
                Provider.of<EmailPasswordAuthData>(context, listen: false)
                    .toggleAuthView(),
            child: Text("Tap to Sign In"),
          ),
        ],
      ),
    );
  }
}

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _email;
  late String _password;

  _onActionButtonTap() {
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
            onSaved: (value) {
              setState(() {
                _password = value!;
              });
            },
            obscureText: true,
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
            onTap: () =>
                Provider.of<EmailPasswordAuthData>(context, listen: false)
                    .toggleAuthView(),
            child: Text("Tap to Sign Up"),
          ),
        ],
      ),
    );
  }
}
