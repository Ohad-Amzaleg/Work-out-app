import 'package:flutter/material.dart';
import 'package:my_gym/Util//rounded_button.dart';
import 'package:my_gym/Util/text_box.dart';
import 'package:my_gym/Util/user_validation.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  static const String id='LoginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';

  @override
   Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: const Image(
                        image: AssetImage('images/logo.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                    child: Text(
                      'Username',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  TextBox(
                    hintText: 'Enter your Username',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      username = value;
                    },
                  ),
                  const SizedBox(
                    height: 24.0,
                    child: Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  TextBox(
                    hintText: 'Enter your password',
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                    title: 'Log In',
                    color: Colors.blueGrey,
                    onPressed: () async {
                      UserValid.LoginValidation(context, username, password);
                    },
                  ),
                ],
              ),
            ),
      );
  }
}
