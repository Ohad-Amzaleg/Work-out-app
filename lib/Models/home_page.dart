import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_gym/Models/my_workout_page.dart';
import 'package:my_gym/Models/settings_page.dart';

import 'my_food_page.dart';
import 'my_music_page.dart';

class HomePage extends StatelessWidget {
  static const String id = 'HomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 80.0,
                        child: const Image(
                          image: AssetImage('images/logo.png'),
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
                      ))
                    ],
                  ),
                ),
                const SizedBox(height: 70.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildBox(context, Icons.fitness_center, 'My Workout'),
                    const SizedBox(width: 40.0),
                    _buildBox(context, Icons.fastfood, 'My Food'),
                  ],
                ),
                const SizedBox(height: 150.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildBox(context, Icons.music_note, 'My Music'),
                    const SizedBox(width: 40.0),
                    _buildBox(context, Icons.settings, 'Settings'),
                  ],
                ),
              ],
            ),
          ),
        );
  }

 Widget _buildBox(BuildContext context, IconData iconData, String text) {
    return ElevatedButton(
      onPressed: text == 'My Workout'
          ? () => Navigator.pushNamed(context, MyWorkoutPage.id)
          : text == 'My Food'
              ? () => Navigator.pushNamed(context, MyFood.id)
              : text == 'My Music'
                  ? () => Navigator.pushNamed(context, MyMusic.id)
                  : text == 'Settings'
                      ? () => Navigator.pushNamed(context, SettingsPage.id)
                      : null,
      style: ElevatedButton.styleFrom(
        primary: Colors.blueGrey,
        onPrimary: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
      child: SizedBox(
        width: 120.0,
        height: 150.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 50.0),
            const SizedBox(height: 10.0),
            Text(text, style: const TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}
