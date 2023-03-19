import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_gym/Models/home_page.dart';
import 'package:my_gym/Util/Database.dart';

import '../Util/excerecise.dart';
import '../Util/rounded_button.dart';
import 'exercise_picker_page.dart';

class ExerciseListPage extends StatefulWidget {
  static const String id = 'ExerciseListPage';
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  bool changesMade = false;
  late List<Exercise> exercises;
  final String workoutName;
  List<int> exerciseIndexToUpdate = [];

  ExerciseListPage(
      {Key? key, required this.workoutName, required this.exercises})
      : super(key: key);

  @override
  _ExerciseListPageState createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  int _currentIndex = -1;

  void _startWorkout() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutName),
        actions: [
          Visibility(
            visible: widget.changesMade,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  for (int index in widget.exerciseIndexToUpdate) {
                    DataBase.updateExercise(
                        widget.workoutName,
                        widget.exercises[index].name,
                        widget._auth.currentUser?.email ?? '',
                        widget.exercises[index].reps,
                        widget.exercises[index].sets,
                        widget.exercises[index].weight);
                  }

                  widget.changesMade = false;
                });
              },
              child: Text('Save Changes'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: _startWorkout,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.exercises.length + 1,
              itemBuilder: (context, index) {
                if (index == widget.exercises.length) {
                  // return button widget
                  return SizedBox(
                    height: 64,
                    child: Material(
                      borderRadius: BorderRadius.circular(40),
                      elevation: 5.0,
                      child: ElevatedButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExercisePickerPage(
                                workoutName: widget.workoutName,
                              ),
                            ),
                          );
                          widget.exercises = await DataBase.getWorkoutExercises(
                              widget.workoutName,
                              widget._auth.currentUser?.email ?? '');
                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add),
                            SizedBox(width: 8),
                            Text('Add Exercise'),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  Exercise exercise = widget.exercises[index];
                  return GestureDetector(
                    onTap: _currentIndex >= 0
                        ? () {
                            setState(() {
                              index == _currentIndex ? Icon(Icons.check) : null;
                              _currentIndex = index;
                            });
                          }
                        : () {
                            setState(() {
                              int sets = 0;
                              int reps = 0;
                              int weight = 0;
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: const Text('Edit Exercise'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          TextField(
                                            onChanged: (value) {
                                              sets = int.parse(value);
                                            },
                                            decoration: const InputDecoration(
                                              hintText: 'Enter Sets',
                                            ),
                                          ),
                                          TextField(
                                            onChanged: (value) {
                                              reps = int.parse(value);
                                            },
                                            decoration: const InputDecoration(
                                              hintText: 'Enter Reps',
                                            ),
                                          ),
                                          TextField(
                                            onChanged: (value) {
                                              weight = int.parse(value);
                                            },
                                            decoration: const InputDecoration(
                                              hintText: 'Enter Weight',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      SizedBox(
                                        width: 100,
                                        child: RoundedButton(
                                          title: 'Cancel',
                                          color: Colors.blueGrey,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: RoundedButton(
                                          title: 'Save',
                                          color: Colors.blueGrey,
                                          onPressed: () async {
                                            setState(() {
                                              Navigator.pop(context);
                                              widget.exerciseIndexToUpdate
                                                  .add(index);
                                              widget.exercises[index].sets =
                                                  sets;
                                              widget.exercises[index].reps =
                                                  reps;
                                              widget.exercises[index].weight =
                                                  weight;
                                              widget.changesMade = true;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                              ;
                            });
                          },
                    child: Container(
                      color: index == _currentIndex ? Colors.yellow : null,
                      child: ListTile(
                        title: Text(exercise.name),
                        subtitle: Text(
                            'Sets: ${exercise.sets} Reps: ${exercise.reps} Weight: ${exercise.weight}'),
                        selected: index == _currentIndex,
                        trailing: index == _currentIndex
                            ? Icon(Icons.check_box)
                            : null,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
