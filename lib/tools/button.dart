import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double padding;
  final double width;
  final double height;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = const Color.fromARGB(255, 99, 142, 201), // Soft red as default button background
    this.textColor = const Color.fromARGB(255, 240, 243, 250), // White text color
    this.borderRadius = 30.0, // Rounded corners for the button
    this.padding = 16.0,
    this.width = double.infinity,
    this.height = 50.0, // Default button height
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.all(padding),
        minimumSize: Size(width, height), // Set fixed size for button
        elevation: 0, // Set elevation to 0 to remove the shadow
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(color: textColor, fontSize: 16),
      ),
    );
  }
}
