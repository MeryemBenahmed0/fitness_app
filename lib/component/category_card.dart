import 'package:flutter/material.dart';
import 'package:test_app/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Center( // Center to adjust width relative to the screen
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8), // Removed horizontal margin for full width
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Reduced border radius
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400), // Set maximum width for the card
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Align items at the top
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8), // Image rounded corners
                  child: Image.network(
                    category.image,
                    height: 120, // Image height increased
                    width: 200,  // Image width increased
                    fit: BoxFit.cover, // Ensures the image covers the area
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.broken_image,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(width: 16), // Spacing between image and text
                // Title Text on the right
                Expanded(
                  child: Text(
                    category.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18, // Increased text size
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
