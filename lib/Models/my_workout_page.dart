import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_gym/Models/selected_work_out.dart';
import 'package:my_gym/Models/workout_maker.dart';
import 'package:my_gym/Util/Database.dart';

import '../Util/excerecise.dart';
import '../Util/rounded_button.dart';
import 'exercise_picker_page.dart';

class MyWorkoutPage extends StatefulWidget {
  static const String id = 'MyWorkoutPage';

  @override
  State<MyWorkoutPage> createState() => _MyWorkoutPageState();
}

class _MyWorkoutPageState extends State<MyWorkoutPage> {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<QuerySnapshot> workoutsQuerySnapshotFuture;

  @override
  void initState() {
    super.initState();
    workoutsQuerySnapshotFuture = getWorkouts();
  }

  Future<QuerySnapshot> getWorkouts() async {
    CollectionReference workoutsCollection =
        _firestore.collection(DataBase.workoutCollection);
    QuerySnapshot workoutsQuerySnapshot = await workoutsCollection
        .where(DataBase.workOutUserEmail, isEqualTo: _auth.currentUser?.email)
        .get();
    return workoutsQuerySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    print('build has been done');
    workoutsQuerySnapshotFuture = getWorkouts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Workout'),
      ),
      body: FutureBuilder(
        future: workoutsQuerySnapshotFuture,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          QuerySnapshot workoutsQuerySnapshot = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: InkWell(
                        onLongPress: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  title: const Text('Delete Workout'),
                                  content: const Text(
                                      'Are you sure you want to delete this workout?'),
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
                                        title: 'Delete',
                                        color: Colors.blueGrey,
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          String workoutName =
                                              workoutsQuerySnapshot.docs[index]
                                                  ['name'];
                                          await DataBase.deleteWorkout(
                                              workoutName,
                                              _auth.currentUser?.email ?? '');
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        onTap: () async {
                          String workoutName =
                              workoutsQuerySnapshot.docs[index]['name'];
                          List<Exercise> workoutmakerexercises =
                              await DataBase.getWorkoutExercises(
                                  workoutName, _auth.currentUser?.email ?? '');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExerciseListPage(
                                exercises: workoutmakerexercises,
                                workoutName: workoutName,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 16.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  workoutsQuerySnapshot.docs[index]['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: workoutsQuerySnapshot.docs.length,
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 32.0,
                  ),
                ),
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Add Workout'),
                        content: TextField(
                          onChanged: (value) {
                            WorkoutMaker.workout.name = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Workout Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            filled: true,
                            fillColor: Colors.grey,
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 32.0,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              bool workoutExists =
                                  await DataBase.containsWorkout(
                                      WorkoutMaker.workout.name,
                                      _auth.currentUser?.email ?? '');
                              if (workoutExists) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Workout Already Exists'),
                                        content: const Text(
                                            'Please choose a different name'),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Ok'),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.blueGrey[200],
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 16.0,
                                                horizontal: 32.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                WorkoutMaker.workout.userEmail =
                                    _auth.currentUser?.email ?? '';
                                Navigator.pop(context);
                                await Navigator.pushNamed(
                                    context, WorkoutMaker.id);
                                setState(() {});
                              }
                            },
                            child: const Text('Save'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 32.0,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  'Create New Workout',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
