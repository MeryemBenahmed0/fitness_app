import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:test_app/models/user_profile.dart';

class ProfileCard extends StatefulWidget {
  final UserProfile userProfile;
  final Box<UserProfile> box;

  const ProfileCard({super.key, required this.userProfile, required this.box});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final Map<String, bool> _editMode = {
    'name': false,
    'sex': false,
    'age': false,
    'height': false,
    'weight': false,
  };

  @override
 @override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Welcome Message
        Text(
          'Welcome back, ${widget.userProfile.name}!',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF050A1A)
          ),
        ),
        const SizedBox(height: 16),
         const Text(
          'Personal Details',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Color.fromARGB(255, 50, 48, 48),
          ),
        ),
         const SizedBox(height: 8),

        // Editable Profile Fields
        _buildEditableField(
          context,
          fieldKey: 'name',
          icon: Icons.person,
          label: 'Name',
          initialValue: widget.userProfile.name,
          onChanged: (value) => _updateProfile(name: value),
        ),
        const SizedBox(height: 16),
        _buildEditableField(
          context,
          fieldKey: 'sex',
          icon: Icons.female,
          label: 'Sex',
          initialValue: widget.userProfile.sex,
          onChanged: (value) => _updateProfile(sex: value),
        ),
        const SizedBox(height: 16),
        _buildEditableField(
          context,
          fieldKey: 'age',
          icon: Icons.calendar_today,
          label: 'Age',
          initialValue: widget.userProfile.age.toString(),
          keyboardType: TextInputType.number,
          onChanged: (value) =>
              _updateProfile(age: int.tryParse(value) ?? widget.userProfile.age),
        ),
        const SizedBox(height: 16),

        // Height and Weight in the same row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildEditableField(
                context,
               
                fieldKey: 'height',
                icon: Icons.height,
                label: 'Height (cm)',
                initialValue: widget.userProfile.height.toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    _updateProfile(height: double.tryParse(value) ?? widget.userProfile.height),
              ),
            ),
            const SizedBox(width: 16),  // Add space between the two fields
            Expanded(
              child: _buildEditableField(
                context,
                fieldKey: 'weight',
                icon: Icons.monitor_weight,
                label: 'Weight (kg)',
                initialValue: widget.userProfile.weight.toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                    _updateProfile(weight: double.tryParse(value) ?? widget.userProfile.weight),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}


  Widget _buildEditableField(
    BuildContext context, {
    required String fieldKey,
    required IconData icon,
    required String label,
    required String initialValue,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        
        borderRadius: BorderRadius.circular(12.0),
        
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      height: 60.0,
      child: Row(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 111, 124, 132), size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: _editMode[fieldKey]!
                ? TextField(
                    controller: TextEditingController(text: initialValue)
                      ..selection = TextSelection.collapsed(offset: initialValue.length),
                    decoration: InputDecoration(
                      labelText: label,
                      border: InputBorder.none,
                    ),
                    keyboardType: keyboardType,
                    style: const TextStyle(fontSize: 16),
                    onChanged: onChanged,
                    onSubmitted: (value) {
                      // Exit edit mode when the user submits the text
                      setState(() {
                        _editMode[fieldKey] = false;
                      });
                    },
                  )
                : Text(
                    initialValue,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
          ),
          IconButton(
            icon: Icon(
              _editMode[fieldKey]! ? Icons.check : Icons.edit,
              color: const Color.fromARGB(255, 91, 154, 205),
            ),
            onPressed: () {
              setState(() {
                _editMode[fieldKey] = !_editMode[fieldKey]!;
              });
            },
          ),
        ],
      ),
    );
  }

  void _updateProfile({
    String? name,
    String? sex,
    int? age,
    double? height,
    double? weight,
  }) {
    // Update the user profile in the Hive box
    var updatedProfile = UserProfile(
      name: name ?? widget.userProfile.name,
      sex: sex ?? widget.userProfile.sex,
      age: age ?? widget.userProfile.age,
      height: height ?? widget.userProfile.height,
      weight: weight ?? widget.userProfile.weight,
    );
    widget.box.put('userProfile', updatedProfile);
  }
}
