import 'package:hive/hive.dart';
import 'package:test_app/models/workout_model.dart';

Future<void> saveWorkout(Workout workout) async {
  final box = Hive.box<Workout>('myWorkouts');
  if (!box.values.any((saved) => saved.id == workout.id)) {
    await box.add(workout);
  }
}

List<Workout> getSavedWorkouts() {
  final box = Hive.box<Workout>('myWorkouts');
  return box.values.toList();
}
