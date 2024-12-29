import 'package:flutter/material.dart';
import 'package:test_app/component/button.dart';
import 'package:test_app/component/result_bmi.dart';
import 'package:test_app/models/user_profile.dart';

class BMICalculator extends StatefulWidget {
  final UserProfile userProfile;

  const BMICalculator({Key? key, required this.userProfile}) : super(key: key);

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  String _bmiResult = '';
  String _category = '';
  double _bmiValue = 0.0;

  void _calculateBMI() {
    double heightInMeters = widget.userProfile.height / 100; // Convert cm to meters
    double weight = widget.userProfile.weight;

    if (heightInMeters > 0 && weight > 0) {
      double bmi = weight / (heightInMeters * heightInMeters);

      String result = bmi.toStringAsFixed(1); // Format to 1 decimal place
      String category;
      double progressValue = bmi / 40; // Normalize the progress for BMI chart (max 40)

      if (bmi < 18.5) {
        category = 'Underweight';
      } else if (bmi < 24.9) {
        category = 'Normal weight';
      } else if (bmi < 29.9) {
        category = 'Overweight';
      } else {
        category = 'Obesity';
      }

      setState(() {
        _bmiResult = 'Your BMI is $result ($category)';
        _category = category;
        _bmiValue = progressValue; // Set BMI value for circular progress
      });
    } else {
      setState(() {
        _bmiResult = 'Invalid height or weight in the profile. Please update your profile.';
        _category = '';
        _bmiValue = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String motivationalMessage = '';

    // Customize the motivational message based on the BMI category
    if (_category == 'Normal weight') {
      motivationalMessage = 'You are in a healthy weight range. Let\'s work hard to maintain it!';
    } else if (_category == 'Underweight') {
      motivationalMessage = 'You\'re underweight. Let\'s focus on gaining weight healthily!';
    } else if (_category == 'Overweight') {
      motivationalMessage = 'You\'re overweight. Let\'s work on achieving a healthy weight!';
    } else if (_category == 'Obesity') {
      motivationalMessage = 'Obesity detected. Let\'s start working on improving your health!';
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 221, 231, 243), // Gradient start color
                Color.fromARGB(255, 221, 226, 244), // Gradient end color
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.6), // White shadow with opacity
                blurRadius: 15.0, // Blur radius
                offset: Offset(3, 4), // Vertical offset of the shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Height and weight displayed without cards, just icons and text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Height display
                    Column(
                      children: [
                        Icon(Icons.height, color: Color.fromARGB(255, 68, 72, 84), size: 30),
                        SizedBox(height: 4),
                        Text(
                          '${widget.userProfile.height.toStringAsFixed(1)} cm',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Height',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16), // Space between height and weight
                    // Divider line
                    Container(
                      height: 40, // Height of the divider
                      width: 1, // Width of the divider
                      color: Colors.grey[400], // Color of the divider
                    ),
                    SizedBox(width: 16), // Space between divider and weight
                    // Weight display
                    Column(
                      children: [
                        Icon(Icons.fitness_center, color: Color.fromARGB(255, 62, 83, 112), size: 30),
                        SizedBox(height: 4),
                        Text(
                          '${widget.userProfile.weight.toStringAsFixed(1)} kg',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Weight',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.0),

                // Custom button for BMI calculation
                Center(
                  child: CustomButton(
                    label: 'Calculate BMI',
                    onPressed: _calculateBMI,
                    backgroundColor: const Color.fromARGB(255, 99, 142, 201),
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),

                // Display BMI results
                if (_bmiResult.isNotEmpty)
                  BMIResultWidget(
                    bmiValue: _bmiValue,
                    bmiResult: _bmiResult,
                    category: _category,
                    motivationalMessage: motivationalMessage,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
