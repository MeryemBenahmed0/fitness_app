
import 'package:flutter/material.dart';
import 'package:test_app/helpers/workout_utils.dart';
import 'package:test_app/models/workout_model.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final VoidCallback onViewDetails;

  const WorkoutCard({
    super.key,
    required this.workout,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        title: Text(
          workout.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Text('${workout.duration} | Purpose: ${workout.purpose}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.info, color: Colors.blue),
              onPressed: onViewDetails,
            ),
            IconButton(
              icon: const Icon(Icons.bookmark_add, color: Colors.green),
              onPressed: () async {
                await saveWorkout(workout); // Using the helper
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Workout saved!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
