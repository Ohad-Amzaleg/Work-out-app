import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_gym/Models/home_page.dart';
import 'package:my_gym/Models/login_page.dart';
import 'package:my_gym/Models/my_food_page.dart';
import 'package:my_gym/Models/my_music_page.dart';
import 'package:my_gym/Models/my_workout_page.dart';
import 'package:my_gym/Models/registration_page.dart';
import 'package:my_gym/Models/excercises_api.dart';
import 'package:my_gym/Models/settings_page.dart';
import 'package:my_gym/Models/welcome_page.dart';
import 'package:my_gym/Models/exercise_picker_page.dart';

import 'Models/workout_maker.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyGymApp());
}
class MyGymApp extends StatelessWidget {
  const MyGymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
         bodyLarge: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomePage.id,
      routes:{
        WelcomePage.id:(context)=>WelcomePage(),
        LoginPage.id:(context)=>LoginPage(),
        RegPage.id:(context)=>RegPage(),
        HomePage.id:(context)=>HomePage(),
        MyFood.id:(context)=>MyFood(),
        MyMusic.id:(context)=>MyMusic(),
        MyWorkoutPage.id:(context)=>MyWorkoutPage(),
        SettingsPage.id:(context)=>SettingsPage(),
        WorkoutMaker.id:(context)=>WorkoutMaker(),

      },
    );
  }
}
