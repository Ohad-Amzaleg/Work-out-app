import 'package:flutter/material.dart';

class PopupMessages {
  static void PopUpMsg(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void ShortPass(BuildContext context) {
    PopUpMsg(context, 'Invalid Password',
        'Password must be at least 6 characters long');
  }

  static void InvalidEmail(BuildContext context) {
    PopUpMsg(context, 'Invalid Email', 'Please enter a valid email address');
  }

  static void InvalidUsername(BuildContext context) {
    PopUpMsg(context, 'Invalid Username',
        'Username must be at least 6 characters long');
  }
}
