import 'package:flutter/material.dart';

import 'excerecise.dart';

class Workout {
   String userEmail;
   String name;
   List<Exercise> exercises;

  Workout({
    required this.userEmail,
    required this.name,
    required this.exercises,
  });
}