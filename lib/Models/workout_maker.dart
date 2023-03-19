import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_gym/Models/exercise_picker_page.dart';
import 'package:my_gym/Util/Database.dart';

import '../Util/Workout.dart';
import '../Util/excerecise.dart';

class WorkoutMaker extends StatefulWidget {
  static const String id = 'WorkoutMaker';
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  static List<Exercise> exercises = [];
  static Workout workout = Workout(userEmail: '', name: '', exercises: exercises);

   WorkoutMaker({Key? key}) : super(key: key);

  @override
  State<WorkoutMaker> createState() => _WorkoutMakerState();
}

class _WorkoutMakerState extends State<WorkoutMaker> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Clear the list of exercises when the user presses the back button
          WorkoutMaker.exercises.clear();
          WorkoutMaker.workout= Workout(userEmail:'', name: '', exercises:WorkoutMaker.exercises);
          return true;
        },
    child: Scaffold(
      appBar: AppBar(
        title: Text(WorkoutMaker.workout.name),
        actions: [
          TextButton(
            onPressed: () {
              // Save the workout to the database
              DataBase.addWorkout(WorkoutMaker.workout.name,WorkoutMaker.workout.userEmail,  WorkoutMaker.workout.exercises);

              // Clear the list of exercises
              WorkoutMaker.exercises.clear();
              WorkoutMaker.workout= Workout(userEmail:'', name: '', exercises:WorkoutMaker.exercises);
              Navigator.pop(context);

            },
            child: const Text('Save Workout'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: WorkoutMaker.exercises.length + 1, // add 1 for the button
        itemBuilder: (context, index) {
          if (index == WorkoutMaker.exercises.length) {
            // return button widget
            return ElevatedButton(
              onPressed: () async {
                await   Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExercisePickerPage(
                      workoutName: 'Workout Maker',
                    ),
                  ),
                );
                setState((){
                });
              },
              child: const Text('Add Exercise'),
            );
          } else {
            // return exercise widget
            return Column(
              children: [
                const Divider(
                  height: 10,
                  thickness: 2,
                ),
                ListTile(
                    title: Text(WorkoutMaker.exercises[index].name),
                    contentPadding: const EdgeInsets.all(10)),
              ],
            );
          }
        },
      ),
    )
    );
  }
}
