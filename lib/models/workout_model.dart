import 'package:hive/hive.dart';

part 'workout_model.g.dart'; // Required for code generation

@HiveType(typeId: 0) // Unique ID for the Workout type
class Workout {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String duration;

  @HiveField(4)
  final String purpose;
   @HiveField(5) // Added new field for completion status
  bool completed;
  

  Workout({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.purpose,
    this.completed = false
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      duration: json['duration'],
      purpose: json['purpose'],
      
    );
  }

  set metadata(Map<String, String> metadata) {}
}
