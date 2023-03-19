import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_gym/Models/workout_maker.dart';
import 'package:my_gym/Util/Database.dart';
import 'dart:convert';

import '../Util/excerecise.dart';
import 'exercise_detail.dart';

class ExercisesPage extends StatefulWidget {
  static const String id = 'ExercisesPage';
  final List<Exercise> exercises;
  final String muscle;
  final String workoutName;

  const ExercisesPage(
      {Key? key,
      required this.exercises,
      required this.muscle,
      required this.workoutName})
      : super(key: key);

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void SortExercises() {
    widget.exercises.sort((a, b) {
      if (a.difficulty == 'beginner' && b.difficulty != 'beginner') {
        return -1; // a is less difficult than b
      } else if (a.difficulty == 'intermediate' && b.difficulty == 'expert') {
        return -1; // a is less difficult than b
      } else {
        return 1; // a is more difficult than b
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SortExercises();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.muscle + ' Exercises'),
      ),
      body: ListView.builder(
        itemCount: widget.exercises.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const Divider(
                height: 10,
                thickness: 2,
              ),
              ListTile(
                title: Text(widget.exercises[index].name),
                contentPadding: const EdgeInsets.all(10),
                trailing: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: widget.exercises[index].difficulty == 'beginner'
                        ? Colors.green
                        : widget.exercises[index].difficulty == 'intermediate'
                            ? Colors.orange
                            : Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(widget.exercises[index].difficulty),
                  ),
                ),
                onTap: () async {
                  print(widget.workoutName);
                  if (widget.workoutName == 'Workout Maker') {
                    if (!WorkoutMaker.exercises
                        .contains(widget.exercises[index])) {
                      WorkoutMaker.exercises.add(widget.exercises[index]);
                    }
                  } else {
                    bool found = await DataBase.checkIfExerciseExist(
                        widget.exercises[index].name,
                        widget.workoutName,
                        _auth.currentUser?.email ?? '');
                    if (!found) {
                      DataBase.addExercise(
                          widget.workoutName,
                          _auth.currentUser?.email ?? '',
                          widget.exercises[index].name,
                          widget.exercises[index].reps,
                          widget.exercises[index].sets,
                          widget.exercises[index].weight);
                    }
                  }
                  setState(() {});

                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExerciseDetailsPage(
                        exercises: widget.exercises[index],
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.info),
                iconSize: 30,
              ),
            ],
          );
        },
      ),
    );
  }
}
