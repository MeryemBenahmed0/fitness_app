import 'package:flutter/material.dart';
import 'package:test_app/sharts_diagrams/circle.dart';

class ProgressDiagram extends StatelessWidget {
  final String label;
  final double progressValue; // Value between 0 and 1
  final int count;
  final Gradient progressGradient;

  const ProgressDiagram({
    super.key,
    required this.label,
    required this.progressValue,
    required this.count,
    required this.progressGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomCircularProgress(
          progressValue: progressValue,
          progressGradient: progressGradient,
          strokeWidth: 8.0,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          '$count Workouts',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
