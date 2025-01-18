import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/component/card_time.dart';
import 'package:test_app/models/workout_model.dart';
import 'package:test_app/sharts_diagrams/circle.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Workout>>(
      valueListenable: Hive.box<Workout>('myWorkouts').listenable(),
      builder: (context, workoutBox, _) {
        final savedWorkouts = workoutBox.values.toList();

        // Calculate workout statistics
        int selectedCount = savedWorkouts.length;
        int completedCount = savedWorkouts.where((workout) => workout.completed).length;
        int remainingCount = selectedCount - completedCount;

        // Sum the duration of completed workouts
        double totalTime = savedWorkouts
            .where((workout) => workout.completed)
            .fold(0.0, (sum, workout) {
          final durationInMinutes = _parseDuration(workout.duration);
          return sum + durationInMinutes;
        });

        // Calculate progress values for the circular progress indicators
        double completedProgress = selectedCount > 0 ? completedCount / selectedCount : 0.0;
        double remainingProgress = selectedCount > 0 ? remainingCount / selectedCount : 0.0;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Circular progress for completed workouts
                  _buildCircularProgressCard(
                    label: 'Completed',
                    progressValue: completedProgress,
                    count: completedCount,
                    gradient: const LinearGradient(
                      colors: [Colors.greenAccent, Colors.green],
                    ),
                  ),
                  // Circular progress for remaining workouts
                  _buildCircularProgressCard(
                    label: 'Remaining',
                    progressValue: remainingProgress,
                    count: remainingCount,
                    gradient: const LinearGradient(
                      colors: [Colors.orangeAccent, Colors.orange],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Total time card
              TotalTimeCard(totalTime: totalTime),
            ],
          ),
        );
      },
    );
  }

  // Helper widget to build a circular progress card
  Widget _buildCircularProgressCard({
    required String label,
    required double progressValue,
    required int count,
    required Gradient gradient,
  }) {
    return Column(
      children: [
        CustomCircularProgress(
          progressValue: progressValue,
          progressGradient: gradient,
          strokeWidth: 8.0,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          '$count Workouts',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
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
