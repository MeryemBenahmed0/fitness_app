import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/models/workout_model.dart';
import 'package:test_app/component/saved_workouts_card.dart';  // Import WorkoutCard
class SavedWorkoutsTab extends StatelessWidget {
  const SavedWorkoutsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Workout>>(
      valueListenable: Hive.box<Workout>('myWorkouts').listenable(), // Listen for changes in the Hive box
      builder: (context, workoutBox, _) {
        final savedWorkouts = workoutBox.values.toList();

        if (savedWorkouts.isEmpty) {
          return const Center(child: Text('No saved workouts yet.'));
        }

        return ListView.builder(
          itemCount: savedWorkouts.length,
          shrinkWrap: true, // Ensure the list uses only the space needed
          physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
          itemBuilder: (context, index) {
            final workout = savedWorkouts[index];

            return Dismissible(
              key: Key(workout.id.toString()), // Use the workout's id as the key
              direction: DismissDirection.startToEnd, // Swipe from left to right to delete
              onDismissed: (direction) {
                // Delete the workout from the Hive box
                workoutBox.deleteAt(index);

                // Show a snack bar message confirming the deletion
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${workout.title} deleted')),
                );
              },
              background: Container(
                color: Colors.red,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              ),
              child: MYWorkoutCard(
                workout: workout,
                onTap: () {
                  // Optional: Navigate to details page or perform other actions
                },
                onCheckboxChanged: (newValue) {
                  // Update the completed status of the workout
                  workout.completed = newValue ?? false;

                  // Save the updated workout back to Hive
                  workoutBox.putAt(index, workout);
                },
              ),
            );
          },
        );
      },
    );
  }
}
