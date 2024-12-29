import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final String? Function(T?)? validator;
  final Color? backgroundColor;

  const CustomDropdownField({
    Key? key,
    required this.label,
    required this.items,
    this.onChanged,
    this.value,
    this.validator,
    this.backgroundColor = const Color.fromARGB(255, 213, 222, 239), // Light grayish lavender from palette
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8), // Spacing between label and dropdown
        DropdownButtonFormField<T>(
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: backgroundColor, // Light grayish lavender background
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          items: items
              .map((item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      item.toString(),
                      style: TextStyle(color: Color(0xFF5b5f97)), // Muted blue for text
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
