import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/models/workout_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Workout>>(
      valueListenable: Hive.box<Workout>('myWorkouts').listenable(),
      builder: (context, workoutBox, _) {
        final savedWorkouts = workoutBox.values.toList();
        
        // Calculate the number of selected workouts, completed workouts, and the total time of completed workouts
        int selectedCount = savedWorkouts.length;
        int completedCount = savedWorkouts.where((workout) => workout.completed).toList().length;
        int remainingCount = selectedCount - completedCount;

        // Sum the duration of completed workouts
        double totalTime = savedWorkouts
            .where((workout) => workout.completed)
            .fold(0.0, (sum, workout) {
              // Try to extract numeric value from the duration string (e.g., "30 minutes" -> 30)
              final durationInMinutes = _parseDuration(workout.duration);
              return sum + durationInMinutes;
            });

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Workouts Summary',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text('Total Workouts: $selectedCount'),
              Text('Completed Workouts: $completedCount'),
              Text('Remaining Workouts: $remainingCount'),
              Text('Total Time (Completed): ${totalTime.toStringAsFixed(2)} minutes'),
            ],
          ),
        );
      },
    );
  }

  // Helper function to extract numeric duration from a string (e.g., "30 minutes" -> 30)
  double _parseDuration(String duration) {
    final match = RegExp(r'(\d+\.?\d*)').firstMatch(duration);
    if (match != null) {
      final durationString = match.group(0);
      return double.tryParse(durationString ?? '') ?? 0.0;
    }
    return 0.0;
  }
}
