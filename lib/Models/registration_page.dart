import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_gym/Util/rounded_button.dart';
import 'package:my_gym/Util/text_box.dart';
import 'package:my_gym/Util/popup_messages.dart';

import '../Util/user_validation.dart';
import 'home_page.dart';

class RegPage extends StatefulWidget {
  static const String id = 'RegPage';

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final auth = FirebaseAuth.instance;

  String email = '';
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
                  'Email Address',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              TextBox(
                hintText: 'Enter your email',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
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
                hintText: 'Enter Username',
                obscureText: false,
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
                hintText: 'Enter Password',
                obscureText: true,
                onChanged: (value) {
                    password = value;
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register',
                color: Colors.blueGrey,
                onPressed: () {
                 UserValid.RegValidation(context, email, password, username);
                  },
              ),
            ],
          )),
    );
  }
}
