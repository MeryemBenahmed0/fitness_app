
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final FormFieldSetter<String>? onSaved;
  final String? Function(String?)? validator;
  final IconData? icon;
  final Color? backgroundColor;
  final double verticalSpacing; // Added for space between fields

  const CustomTextField({
    super.key,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.onSaved,
    this.validator,
    this.icon,
    this.backgroundColor = const Color.fromARGB(255, 213, 222, 239), // Light grayish lavender from palette
    this.verticalSpacing = 16.0, // Default space between fields
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: verticalSpacing), // Add space below each field
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8), // Add some spacing between the label and the text field
          TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: backgroundColor,
              prefixIcon: icon != null ? Icon(icon, color: const Color.fromARGB(255, 57, 88, 134)) : null, // Muted blue for icon
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(15.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            keyboardType: keyboardType,
            onSaved: onSaved,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
