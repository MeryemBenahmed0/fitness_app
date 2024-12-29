import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/models/goal.dart';
import 'package:test_app/screens/bottom_bar.dart';
import 'package:test_app/screens/set_profile.dart';
import 'models/user_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register the Hive adapters
  Hive.registerAdapter(UserProfileAdapter());
  Hive.registerAdapter(GoalAdapter()); // Add this if you're using a Goal model

  // Open necessary Hive boxes
  await Hive.openBox<UserProfile>('userProfileBox');
  await Hive.openBox<Goal>('goalsBox'); // Open other required boxes

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        '/': (context) => UserProfileSetupScreen(),
        '/main': (context) =>MainScreen(),
      },
    );
  }
}
