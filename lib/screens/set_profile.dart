import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:test_app/component/button.dart';
import 'package:test_app/component/card.dart';
import 'package:test_app/component/drop_down.dart';
import 'package:test_app/component/text_feild.dart';
import 'package:test_app/models/user_profile.dart';

class UserProfileSetupScreen extends StatefulWidget {
  @override
  _UserProfileSetupScreenState createState() => _UserProfileSetupScreenState();
}

class _UserProfileSetupScreenState extends State<UserProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? sex;
  int? age;
  double? height;
  double? weight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Set Your Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 241, 243, 247),
          ),
        ),
        centerTitle: true,
        backgroundColor:Color.fromARGB(255, 50, 63, 100),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/1226dda4d6a576dd3ce82fbdbe537838.jpg'), // Path to your image
            fit: BoxFit.cover, // Ensures the image covers the entire screen
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Fill this form so you can set up your profile',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 75, 84, 100),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: CustomCard(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              label: 'Name',
                              onSaved: (value) => name = value,
                              icon: Icons.person,
                            ),
                            CustomDropdownField<String>(
                              label: 'Sex',
                              items: ['Male', 'Female'],
                              onChanged: (value) => sex = value,
                              value: sex,
                            ),
                            CustomTextField(
                              label: 'Age',
                              keyboardType: TextInputType.number,
                              onSaved: (value) => age = int.tryParse(value ?? ''),
                              icon: Icons.calendar_today,
                            ),
                            CustomTextField(
                              label: 'Height (cm)',
                              keyboardType: TextInputType.number,
                              onSaved: (value) => height = double.tryParse(value ?? ''),
                              icon: Icons.height,
                            ),
                            CustomTextField(
                              label: 'Weight (kg)',
                              keyboardType: TextInputType.number,
                              onSaved: (value) => weight = double.tryParse(value ?? ''),
                              icon: Icons.fitness_center,
                            ),
                            SizedBox(height: 20),
                            CustomButton(
                              label: 'Next',
                              backgroundColor: Color.fromARGB(255, 50, 63, 100),
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ?? false) {
                                  _formKey.currentState?.save();

                                  var box = await Hive.openBox<UserProfile>('userProfileBox');
                                  var userProfile = UserProfile(
                                    name: name!,
                                    sex: sex!,
                                    age: age!,
                                    height: height!,
                                    weight: weight!,
                                  );
                                  await box.put('userProfile', userProfile);

                                  // Navigate to the MainScreen with BottomNavigationBar
                                  Navigator.pushReplacementNamed(context, '/main');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
