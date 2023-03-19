import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'excerecise.dart';

class DataBase {
  static late FirebaseAuth _auth;
  static late FirebaseFirestore _firestore;
  static const String WorkoutDocId = 'pl3hzXxPCJqQhocQudpU';
  static const String workoutCollection = 'workout';
  static const String workOutName = 'name';
  static const String workOutUserEmail = 'userEmail';
  static const String workOutExercises = 'exercises';
  static const String exerciseName = 'name';
  static const String exerciseReps = 'reps';
  static const String exerciseSets = 'sets';
  static const String exerciseWeight = 'weight';


  static Future<bool> containsWorkout(String workoutName, String userEmail) async {
    CollectionReference workoutsRef =
        FirebaseFirestore.instance.collection(DataBase.workoutCollection);
    Query query = workoutsRef
        .where(DataBase.workOutName, isEqualTo: workoutName)
        .where(DataBase.workOutUserEmail, isEqualTo: userEmail);
    QuerySnapshot querySnapshot = await query.get();
    return querySnapshot.docs.length != 0;
  }


  static void updateWorkoutExercises(
      String workoutName, String userEmail, List<Exercise> exercises) async {
    CollectionReference workoutsRef =
        FirebaseFirestore.instance.collection(DataBase.workoutCollection);
    Query query = workoutsRef
        .where(DataBase.workOutName, isEqualTo: workoutName)
        .where(DataBase.workOutUserEmail, isEqualTo: userEmail);
    QuerySnapshot querySnapshot = await query.get();
    querySnapshot.docs[0].reference.update({
      DataBase.workOutExercises: exercises.map((e) => e.toJson()).toList(),
    });
  }

  static Future<bool> deleteWorkout(
      String workoutName, String userEmail) async {
    CollectionReference workoutsRef =
        FirebaseFirestore.instance.collection(DataBase.workoutCollection);
    Query query = workoutsRef
        .where(DataBase.workOutName, isEqualTo: workoutName)
        .where(DataBase.workOutUserEmail, isEqualTo: userEmail);
    QuerySnapshot querySnapshot = await query.get();

    //Check if workout exists
    if (querySnapshot.docs.length == 0) {
      return false;
    }

    //Get exercises ref
    CollectionReference exercisesRef =
        await getWorkoutExercisesRef(workoutName, userEmail);
    //Deep delete all exercises
    QuerySnapshot exercisesSnapshot = await exercisesRef.get();
    exercisesSnapshot.docs.forEach((exerciseDoc) {
      exerciseDoc.reference.delete();
    });
    //Delete workout
    querySnapshot.docs[0].reference.delete();
    return true;
  }

  static void addWorkout(
      String workoutName, String userEmail, List<Exercise> exercises) async {
    var newWorkoutRef =
        FirebaseFirestore.instance.collection(DataBase.workoutCollection).doc();
    var newExerciseRef =
        newWorkoutRef.collection(DataBase.workOutExercises).doc();
    newWorkoutRef.set({
      DataBase.workOutName: workoutName,
      DataBase.workOutUserEmail: userEmail,
    });
    for (Exercise exercise in exercises) {
      newExerciseRef.set(exercise.toJson());
    }
  }

  static Future<CollectionReference<Map<String, dynamic>>>
      getWorkoutExercisesRef(String workoutName, String userEmail) async {
    CollectionReference workoutsRef =
        FirebaseFirestore.instance.collection(DataBase.workoutCollection);
    Query query = workoutsRef
        .where(DataBase.workOutName, isEqualTo: workoutName)
        .where(DataBase.workOutUserEmail, isEqualTo: userEmail);
    QuerySnapshot querySnapshot = await query.get();
    return querySnapshot.docs[0].reference
        .collection(DataBase.workOutExercises);
  }

  static Future<List<Exercise>> getWorkoutExercises(
      String workoutName, String userEmail) async {
    CollectionReference workoutsRef =
        FirebaseFirestore.instance.collection(DataBase.workoutCollection);
    Query query = workoutsRef
        .where(DataBase.workOutName, isEqualTo: workoutName)
        .where(DataBase.workOutUserEmail, isEqualTo: userEmail);
    QuerySnapshot querySnapshot = await query.get();
    CollectionReference exercisesRef =
        querySnapshot.docs[0].reference.collection(DataBase.workOutExercises);

    List<Exercise> exercises = [];
    QuerySnapshot exercisesSnapshot = await exercisesRef.get();
    print(exercisesSnapshot.docs.length);
    exercisesSnapshot.docs.forEach((exerciseDoc) {
      Map<String, dynamic> data = exerciseDoc.data() as Map<String, dynamic>;
      print(data[DataBase.exerciseName]);
      Exercise exercise = Exercise(
        name: data[DataBase.exerciseName],
        reps: data[DataBase.exerciseReps],
        sets: data[DataBase.exerciseSets],
        difficulty: '',
        instructions: '',
        type: '',
        weight: data[DataBase.exerciseWeight],
      );
      exercises.add(exercise);
    });

    return exercises;
  }

  // static Future<List<Exercise>> getWorkoutExercises(String workoutName, String userEmail) async{
  //   CollectionReference exercisesRef = await getWorkoutExercisesRef(workoutName, userEmail);
  //   List<Exercise> exercise= [];
  //   await exercisesRef.get().then((value) => value.docs.forEach((element) {
  //     exercise.add(Exercise.fromJson(element.data() as Map<String, dynamic>));
  //   }));
  //   return exercise;
  // }

  static void updateExercise(String workoutName, String exerciseName,
      String userEmail, int reps, int sets, int weight) async {
    CollectionReference excercisesRef =
        await getWorkoutExercisesRef(workoutName, userEmail);
    Query query =
        excercisesRef.where(DataBase.exerciseName, isEqualTo: exerciseName);
    QuerySnapshot querySnapshot = await query.get();
    querySnapshot.docs[0].reference.update({
      DataBase.exerciseReps: reps,
      DataBase.exerciseSets: sets,
      DataBase.exerciseWeight: weight,
    });
  }

  static void deleteExercise(String exerciseName, String userEmail, String workoutName) async {
    CollectionReference excercisesRef =
        await getWorkoutExercisesRef(workoutName, userEmail);
    Query query =
        excercisesRef.where(DataBase.exerciseName, isEqualTo: exerciseName);
    QuerySnapshot querySnapshot = await query.get();
    querySnapshot.docs[0].reference.delete();
  }

  static void addExercise(String workoutName, String userEmail,
      String exerciseName, int reps, int sets, int weight) async {
    CollectionReference excercisesRef =
        await getWorkoutExercisesRef(workoutName, userEmail);
    excercisesRef.add({
      DataBase.exerciseName: exerciseName,
      DataBase.exerciseReps: reps,
      DataBase.exerciseSets: sets,
      DataBase.exerciseWeight: weight,
    });
  }

  static Future<bool> checkIfExerciseExist(
      String exerciseName, String workoutName, String userEmail) async {
    CollectionReference excercisesRef =
        await getWorkoutExercisesRef(workoutName, userEmail);
    Query query =
        excercisesRef.where(DataBase.exerciseName, isEqualTo: exerciseName);
    QuerySnapshot querySnapshot = await query.get();
    return querySnapshot.docs.isNotEmpty;
  }
}
