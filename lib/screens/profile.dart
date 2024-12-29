import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/component/goal_card.dart';
import 'package:test_app/component/profile_card.dart';
import 'package:test_app/models/goal.dart';
import 'package:test_app/models/user_profile.dart';
import 'package:test_app/component/bmi_calculator.dart'; // Import BMI calculator component

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 238, 243),
      body: ValueListenableBuilder<Box<UserProfile>>(
        valueListenable: Hive.box<UserProfile>('userProfileBox').listenable(),
        builder: (context, box, _) {
          var userProfile = box.get('userProfile');

          if (userProfile == null) {
            return Center(child: Text('No profile data found.'));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User information with a curved transition and image background
                Stack(
                  children: [
                    // Purple section with a curved transition and an image as background
                    ClipPath(
                      clipper: CurvedTransitionClipper(),
                      child: Container(
                        height: 530,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/Untitled design.png'), // Set your image here
                            fit: BoxFit.cover, // Adjust image to fit the container
                          ),
                        ),
                      ),
                    ),
                    // White section for user info
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ProfileCard(userProfile: userProfile, box: box),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 1.0),
                  child: Text(
                    'Your Fitness Goals',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 50, 63, 100),
                    ),
                  ),
                ),
                ValueListenableBuilder<Box<Goal>>(
                  valueListenable: Hive.box<Goal>('goalsBox').listenable(),
                  builder: (context, goalsBox, _) {
                    var goals = goalsBox.values.toList();
                    if (goals.isEmpty) {
                      return Center(child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('No goals added.'),
                      ));
                    }

                    return ListView.builder(
                      itemCount: goals.length,
                      shrinkWrap: true, // Make the ListView occupy only the required height
                      physics: NeverScrollableScrollPhysics(), // Disable inner scroll
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(goals[index].id.toString()),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            goalsBox.deleteAt(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Goal deleted')),
                            );
                          },
                          background: Container(
                            color: Colors.red,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                          ),
                          child: GoalCard(goal: goals[index]),
                        );
                      },
                    );
                  },
                ),
                
                // BMI Calculator Section with a title
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title for BMI Calculator section
                      Text(
                        'Check Your BMI',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 50, 63, 100),
                        ),
                      ),
                      SizedBox(height: 8), // Space between title and calculator
                      BMICalculator(userProfile: userProfile), // Pass the userProfile for BMI calculation
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CurvedTransitionClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
