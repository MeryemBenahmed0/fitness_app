import 'dart:ui';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double sigmaX;
  final double sigmaY;

  CustomCard({
    required this.child,
    this.borderRadius = 16.0,
    this.sigmaX = 5.0,
    this.sigmaY = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY), // Apply blur effect
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          color: Colors.white.withOpacity(0.3), // Semi-transparent white background
          child: child,
        ),
      ),
    );
  }
}
