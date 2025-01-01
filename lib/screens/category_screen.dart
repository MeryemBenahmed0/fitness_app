
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_app/blocs/category_bloc.dart';
import 'package:test_app/component/category_card.dart';
import 'package:test_app/screens/workout_screen.dart'; // Ensure you import your WorkoutsPage screen

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: BlocProvider(
        create: (context) => CategoryBloc()..add(FetchCategories()), // Initialize and fetch categories
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(child: CircularProgressIndicator()); // Loading state
            } else if (state is CategoryLoaded) {
              return ListView.builder(
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to the WorkoutsPage with the categoryId
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkoutsPage(categoryId: category.id),
                          ),
                        );
                      },
                      child: CategoryCard(category: category), // Use the CategoryCard widget here
                    ),
                  );
                },
              );
            } else if (state is CategoryError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Center(child: Text('No categories available'));
            }
          },
        ),
      ),
    );
  }
}
