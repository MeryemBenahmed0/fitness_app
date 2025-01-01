import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final String? Function(T?)? validator;
  final Color? backgroundColor;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.items,
    this.onChanged,
    this.value,
    this.validator,
    this.backgroundColor = const Color.fromARGB(255, 213, 222, 239), // Light grayish lavender from palette
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8), // Spacing between label and dropdown
        DropdownButtonFormField<T>(
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: backgroundColor, // Light grayish lavender background
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          items: items
              .map((item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      item.toString(),
                      style: const TextStyle(color: Color(0xFF5b5f97)), // Muted blue for text
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
          value: value,
          validator: validator,
        ),
      ],
    );
  }
}
