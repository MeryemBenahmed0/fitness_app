import 'package:hive/hive.dart';
import 'package:test_app/models/workout_model.dart';

Future<void> deleteWorkout(int workoutId) async {
  final box = await Hive.openBox<Workout>('myWorkouts');
  await box.delete(workoutId);  // Delete the workout by its unique ID
}
