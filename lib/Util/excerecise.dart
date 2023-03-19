import 'package:flutter/material.dart';

class Exercise{
  String name;
  String type;
  int reps;
  int sets;
  int weight;
  final String difficulty;
  final String instructions;


  Exercise({
    required this.name,
    required this.type,
    this.reps = 0,
    this.sets = 0,
    this.weight = 0,
    required this.difficulty,
    required this.instructions,
  });
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Exercise &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              type == other.type &&
              difficulty == other.difficulty;

  @override
  int get hashCode => name.hashCode ^ type.hashCode ^ difficulty.hashCode;

  toJson() {
    return {
      'name': name,
      'reps': reps,
      'sets': sets,
      'weight': weight,
    };
  }

  static Exercise fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      type: '',
      reps: json['reps'],
      sets: json['sets'],
      difficulty: '',
      instructions: '',
      weight: json['weight'],
    );
  }
}