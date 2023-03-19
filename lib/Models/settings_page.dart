import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static const String id='SettingsPage';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          const Text('Settings'),
        ],
      ),
    );
  }
}
