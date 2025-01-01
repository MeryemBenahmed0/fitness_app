import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/models/goal.dart';
import 'package:test_app/models/workout_model.dart';
import 'package:test_app/screens/bottom_bar.dart';
import 'package:test_app/screens/mysaved_screen.dart';
import 'package:test_app/screens/set_profile.dart';
import 'package:test_app/models/user_profile.dart';

void deleteBoxFromDisk() async {
  // Deletes all the old data stored in the box (for this case, userProfileBox)
  await Hive.deleteBoxFromDisk('userProfileBox');
  await Hive.deleteBoxFromDisk('goalsBox');
  await Hive.deleteBoxFromDisk('myWorkouts');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Delete old data to ensure new data with updated typeId is used
  deleteBoxFromDisk(); // Or you can clear specific boxes if needed

  // Register the adapters for the models you want to use
  Hive.registerAdapter(UserProfileAdapter());
  Hive.registerAdapter(GoalAdapter());
  Hive.registerAdapter(WorkoutAdapter());

  // Open the necessary Hive boxes after deleting old data
  await Hive.openBox<UserProfile>('userProfileBox');
  await Hive.openBox<Goal>('goalsBox');
  await Hive.openBox<Workout>('myWorkouts');

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Profile Setup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const UserProfileSetupScreen(),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}
