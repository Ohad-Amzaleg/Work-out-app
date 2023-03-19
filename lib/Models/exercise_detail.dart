import 'package:flutter/material.dart';

import '../Util/excerecise.dart';

class ExerciseDetailsPage extends StatelessWidget {
  static const String id = 'ExerciseDetailsPage';
  final Exercise exercises;

  ExerciseDetailsPage({required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercises.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
               exercises.name,
              style: TextStyle(fontSize: 24),
            ),

            SizedBox(height: 20),
            Text(
              'Description: ${exercises.instructions}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
