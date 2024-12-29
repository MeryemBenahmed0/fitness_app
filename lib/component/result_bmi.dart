import 'package:flutter/material.dart';
import 'package:test_app/sharts_diagrams/circle.dart'; // Import the custom progress

class BMIResultWidget extends StatelessWidget {
  final double bmiValue;
  final String bmiResult;
  final String category;
  final String motivationalMessage;

  const BMIResultWidget({
    Key? key,
    required this.bmiValue,
    required this.bmiResult,
    required this.category,
    required this.motivationalMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Choose color based on category
    Gradient progressColor;
    if (category == 'Normal weight') {
      progressColor = LinearGradient(
    colors: [const Color.fromARGB(255, 187, 215, 189), const Color.fromARGB(255, 40, 135, 126)]);
    } else if (category == 'Underweight') {
      progressColor = LinearGradient(
    colors: [const Color.fromARGB(255, 199, 238, 201), const Color.fromARGB(255, 21, 34, 172)]);
    } else if (category == 'Overweight') {
      progressColor = LinearGradient(
    colors: [const Color.fromARGB(255, 255, 129, 32), const Color.fromARGB(255, 122, 21, 0)]);
    } else {
      progressColor = LinearGradient(
    colors: [const Color.fromARGB(255, 255, 129, 32), const Color.fromARGB(255, 122, 21, 0)]);
    }

    // Motivational Message Adjustments for 'Normal weight'
    String fullMessage = motivationalMessage;
    if (category == 'Normal weight') {
      fullMessage = "You're doing great! Keep it up and maintain your healthy weight!";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          // Use CustomCircularProgress for BMI Circle Animation
          CustomCircularProgress(
            progressValue: bmiValue,
            progressGradient: progressColor,
          ),
          SizedBox(height: 16.0),

          // BMI Text
          Text(
            bmiResult,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 50, 63, 100),
            ),
          ),
          SizedBox(height: 16.0),

          // Motivational Message
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              fullMessage,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: const Color.fromARGB(255, 106, 117, 149),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
