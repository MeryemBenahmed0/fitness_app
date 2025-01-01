import 'package:flutter/material.dart';
import 'package:test_app/models/workout_model.dart';
class MYWorkoutCard extends StatelessWidget {
  final Workout workout;
  final VoidCallback onTap;
  final ValueChanged<bool?> onCheckboxChanged;

  const MYWorkoutCard({
    Key? key,
    required this.workout,
    required this.onTap,
    required this.onCheckboxChanged,  // Added a callback for checkbox change
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          workout.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text('${workout.duration} | Purpose: ${workout.purpose}'),
        trailing: Checkbox(
          value: workout.completed,  // Use the completed flag to set the checkbox state
          onChanged: onCheckboxChanged, // Callback when checkbox is tapped
        ),
        onTap: onTap, // Handle tap event to navigate or show details
      ),
    );
  }
}
