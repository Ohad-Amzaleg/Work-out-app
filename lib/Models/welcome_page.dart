import 'package:flutter/material.dart';
import 'package:my_gym/Models/login_page.dart';
import 'package:my_gym/Models/registration_page.dart';
import 'package:my_gym/Util/rounded_button.dart';

class WelcomePage extends StatefulWidget {
  static const String id = 'WelcomePage';

  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 200.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 80.0,
                    child: const Image(
                      image: AssetImage('images/logo.png'),
                    ),
                  ),
                ),
                const Expanded(
                    child: Text(
                  'GymNation',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              color: Colors.blueGrey,
              onPressed: () {
                Navigator.pushNamed(context, LoginPage.id);
              },
            ),
            const SizedBox(
                height: 24.0,
                child: Center(
                  child: Text(
                    'New Here?',
                    style: TextStyle(
                      color: Colors.black,
                      fontFeatures: [],
                      fontSize: 20.0,
                    ),
                  ),
                )),
            RoundedButton(
              title: 'Register',
              color: Colors.blueGrey,
              onPressed: () {
                Navigator.pushNamed(context, RegPage.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
