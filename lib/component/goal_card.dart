import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_app/models/goal.dart';

class GoalCard extends StatelessWidget {
  final Goal goal;

  const GoalCard({super.key, required this.goal});

  // Function to return color based on priority
  Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return const Color.fromARGB(255, 128, 16, 8); // Red for high priority
      case 'medium':
        return const Color.fromARGB(255, 173, 72, 4); // Orange for medium priority
      case 'low':
        return const Color.fromARGB(255, 8, 138, 69); // Green for low priority
      default:
        return Colors.grey; // Default color for unknown priority
    }
  }

  @override
  Widget build(BuildContext context) {
    // Extract day and month for formatting
    final day = DateFormat('d').format(goal.dueDate);
    final month = DateFormat('MMM').format(goal.dueDate).toUpperCase();

    return Container(
      width: double.infinity, // Make the container take the full width of the screen
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0), // Add some padding
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Date section with day on top and month below
            Container(
              width: 60,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 74, 75, 77),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.6), // White shadow with opacity
                    blurRadius: 10.0, // Blur radius
                    offset: const Offset(0, 4), // Position of the shadow (vertical offset)
                  ),
                  BoxShadow(
                    color: const Color.fromARGB(255, 202, 206, 240).withOpacity(0.6), // White shadow with opacity
                    blurRadius: 10.0, // Blur radius
                    offset: const Offset(0, -5), // Position of the shadow (vertical offset)
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 241, 240, 245),
                    ),
                  ),
                  Text(
                    month,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 241, 240, 245),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 9), // Space between date and details

            // Card section for goal details
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 221, 231, 243), // Gradient start color
                        Color.fromARGB(255, 221, 226, 244), // Gradient end color
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.6), // White shadow with opacity
                        blurRadius: 10.0, // Blur radius
                        offset: const Offset(0, 4), // Position of the shadow (vertical offset)
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        // Left side with title and description
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title with bold styling
                              Text(
                                goal.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 50, 63, 100),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2), // Reduced space between title and description

                              // Description with grey color
                              Text(
                                goal.description,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 91, 92, 96),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Right side for priority circle (aligned to center)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: getPriorityColor(goal.priority), // Set the background color based on priority
                            ),
                            child: Center(
                              child: Text(
                                goal.priority[0].toUpperCase(), // Display the first letter of priority
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
