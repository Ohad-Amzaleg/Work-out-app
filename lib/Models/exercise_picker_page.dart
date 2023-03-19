import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert';


import '../Util/excerecise.dart';
import 'excercises_api.dart';

class ExercisePickerPage extends StatefulWidget {
  static const String id = 'ExercisePickerPage';
  final String workoutName;

  const ExercisePickerPage({Key? key,required this.workoutName}) : super(key: key);

  @override
  State<ExercisePickerPage> createState() => _ExercisePickerPageState();
}

class _ExercisePickerPageState extends State<ExercisePickerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Picker'),
      ),
      body: Stack(
        children: [
          Image.asset('images/HumanBody.jpg',
              fit: BoxFit.fill, width: 400, height: 800),
          Positioned(
            right: 300,
            top: 160,
            child: SizedBox(
              width: 15,
              height: 15,
              child: FloatingActionButton(
                heroTag: 'forearms',
                onPressed: () {
                  _navigateToExcerciseScreen(context, 'forearms',widget.workoutName);
                },
                backgroundColor: Colors.yellowAccent,
                mini: true,
              ),
            ),
          ),
          Positioned(
            right: 255,
            top: 145,
            child: SizedBox(
              width: 15,
              height: 15,
              child: FloatingActionButton(
                heroTag: 'Biceps',
                onPressed: () {
                  _navigateToExcerciseScreen(context, 'Biceps',widget.workoutName);
                },
                backgroundColor: Colors.yellowAccent,
                mini: true,
              ),
            ),
          ),
          Positioned(
            right: 230,
            top: 130,
            child: SizedBox(
              width: 15,
              height: 15,
              child: FloatingActionButton(
                heroTag: 'Shoulders',
                onPressed: () {
                  _navigateToExcerciseScreen(context, 'Shoulders',widget.workoutName);
                },
                backgroundColor: Colors.yellowAccent,
                mini: true,
              ),
            ),
          ),
          Positioned(
            right: 210,
            top: 180,
            child: SizedBox(
              width: 15,
              height: 15,
              child: FloatingActionButton(
                heroTag: 'Chest',
                onPressed: () {
                  _navigateToExcerciseScreen(context, 'Chest',widget.workoutName);
                },
                backgroundColor: Colors.yellowAccent,
                mini: true,
              ),
            ),
          ),
          Positioned(
            right: 185,
            top: 250,
            child: SizedBox(
              width: 15,
              height: 15,
              child: FloatingActionButton(
                heroTag: 'abdominals',
                onPressed: () {
                  _navigateToExcerciseScreen(context, 'abdominals',widget.workoutName);
                },
                backgroundColor: Colors.yellowAccent,
                mini: true,
              ),
            ),
          ),
          Positioned(
            right: 215,
            top: 380,
            child: SizedBox(
              width: 15,
              height: 15,
              child: FloatingActionButton(
                heroTag: 'quadriceps',
                onPressed: () {
                  _navigateToExcerciseScreen(context, 'quadriceps',widget.workoutName);
                },
                backgroundColor: Colors.yellowAccent,
                mini: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToExcerciseScreen(BuildContext context, String muscleGroup,String workoutName) async {
    List<Exercise> exercises = await _fetchExerciseData(muscleGroup);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context)
      => ExercisesPage(
        workoutName: workoutName,
          exercises: exercises,
        muscle: muscleGroup
      ),
    ),
    );
  }

  Future<List<Exercise>> _fetchExerciseData(String muscleGroup) async {
    const api_key='6DwKOzATCH7lTKXmRuUsMg==Zb2VLmCIIjNHo9Zt';
    String url='https://api.api-ninjas.com/v1/exercises?muscle=' + muscleGroup;

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'X-Api-Key': api_key,
    });

    if (response.statusCode == 200) {
      List<dynamic> exercisesData = jsonDecode(response.body);
      List<Exercise> exercises = exercisesData.map((exerciseData) {
        return Exercise(
          name: exerciseData['name'],
          type: exerciseData['type'],
          difficulty: exerciseData['difficulty'],
          instructions: exerciseData['instructions'],
        );
      }).toList();
      return exercises;

    }
    else {
      throw 'Can\'t get exercises';
    }

  }
}
