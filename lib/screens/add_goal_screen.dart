import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_app/component/button.dart';
import 'package:test_app/component/drop_down.dart';
import 'package:test_app/component/text_feild.dart';
import 'package:test_app/models/goal.dart';

class AddGoalScreen extends StatefulWidget {
  @override
  _AddGoalScreenState createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  DateTime _dueDate = DateTime.now();
  String _priority = 'Medium';

  Future<void> _addGoal() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      // Open Hive box to store the goal
      var goalBox = await Hive.openBox<Goal>('goalsBox');
      var newGoal = Goal(
        title: _title,
        description: _description,
        dueDate: _dueDate,
        priority: _priority,
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Automatically set an ID
      );

      // Add the goal to the box
      await goalBox.add(newGoal);

      // Show a confirmation snack bar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Goal added successfully!')),
      );

      // Optionally, you can clear the form to add another goal without leaving the screen
      _formKey.currentState?.reset();
      setState(() {
        _dueDate = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Goal')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Input
              CustomTextField(
                label: 'Title',
                keyboardType: TextInputType.text,
                onSaved: (value) => _title = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                verticalSpacing: 16.0,
              ),

              // Description Input
              CustomTextField(
                label: 'Description',
                keyboardType: TextInputType.multiline,
                onSaved: (value) => _description = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                verticalSpacing: 16.0,
                backgroundColor: Colors.grey[100], // Slightly different background for description
              ),

              // Due Date Selection
              Text(
                'Select Due Date',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TableCalendar(
                focusedDay: _dueDate,
                selectedDayPredicate: (day) => isSameDay(_dueDate, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _dueDate = selectedDay;
                  });
                },
                firstDay: DateTime.utc(2020, 01, 01),
                lastDay: DateTime.utc(2100, 12, 31),
                calendarFormat: CalendarFormat.month,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  leftChevronIcon: Icon(Icons.arrow_left),
                  rightChevronIcon: Icon(Icons.arrow_right),
                ),
              ),
              SizedBox(height: 16.0),

              // Priority Selection
              CustomDropdownField<String>(
                label: 'Priority',
                items: ['Low', 'Medium', 'High'],
                value: _priority,
                onChanged: (value) {
                  setState(() {
                    _priority = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a priority';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // Submit Button
              CustomButton(
                label: 'Add Goal',
                onPressed: _addGoal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
