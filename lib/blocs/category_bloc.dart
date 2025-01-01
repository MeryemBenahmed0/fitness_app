import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test_app/models/category_model.dart';

// Event
abstract class CategoryEvent {}

class FetchCategories extends CategoryEvent {}

// State
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  CategoryLoaded(this.categories);
}

class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}

// Bloc
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    // Register the event handler using the `on` method
    on<FetchCategories>(_onFetchCategories);
  }

  Future<void> _onFetchCategories(
    FetchCategories event, Emitter<CategoryState> emit) async {
  emit(CategoryLoading()); // Emit loading state
  try {
    final response = await http.get(
      Uri.parse('https://api.jsonbin.io/v3/b/6771d8b9ad19ca34f8e2cbd4'),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Parsed data: $data');

      // Adjusted JSON parsing
      final List<dynamic> categoriesJson = data['record']['record']['categories'];
      final categories =
          categoriesJson.map((json) => Category.fromJson(json)).toList();
      emit(CategoryLoaded(categories)); // Emit loaded state with categories
    } else {
      emit(CategoryError('Failed to load categories from else'));
    }
  } catch (e, stackTrace) {
    print('Error: $e');
    print('StackTrace: $stackTrace');
    emit(CategoryError('Failed to load categories from catch'));
  }
}
}