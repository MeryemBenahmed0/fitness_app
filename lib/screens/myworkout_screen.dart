import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/models/workout_model.dart';
import 'package:test_app/helpers/workout_utils.dart';
import 'package:test_app/component/saved_workouts_card.dart';  // Import WorkoutCard
import 'package:test_app/screens/dashboard.dart';
import 'package:test_app/screens/mysaved_screen.dart';  // Import your Dashboard screen

class MyWorkoutsPage extends StatelessWidget {
  const MyWorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Workouts'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Saved Workouts'),  // Tab for saved workouts
              Tab(text: 'Dashboard'),       // Tab for dashboard
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SavedWorkoutsTab(), // The widget that displays saved workouts
            DashboardScreen(),  // The widget that displays the dashboard
          ],
        ),
      ),
    );
  }
}