import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test_app/models/workout_model.dart';

// Event
abstract class WorkoutEvent {}

class FetchWorkouts extends WorkoutEvent {
  final int categoryId;
  FetchWorkouts(this.categoryId);
}

// State
abstract class WorkoutState {}

class WorkoutInitial extends WorkoutState {}

class WorkoutLoading extends WorkoutState {}

class WorkoutLoaded extends WorkoutState {
  final List<Workout> workouts;
  WorkoutLoaded(this.workouts);
}

class WorkoutError extends WorkoutState {
  final String message;
  WorkoutError(this.message);
}

// Bloc
class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc() : super(WorkoutInitial()) {
    // Register the event handler using the `on` method
    on<FetchWorkouts>(_onFetchWorkouts);
  }

  Future<void> _onFetchWorkouts(
    FetchWorkouts event, Emitter<WorkoutState> emit) async {
    emit(WorkoutLoading()); // Emit loading state

    try {
      final response = await http.get(
        Uri.parse('https://api.jsonbin.io/v3/b/67719b03ad19ca34f8e2b3d4')
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Parse the JSON data
        final Map<String, dynamic> data = json.decode(response.body)['record']['record'];

        // Filter workouts based on the categoryId
        final List<dynamic> workoutsJson = data['workouts']?.where((workout) {
          return workout['categoryId'] == event.categoryId;
        }).toList() ?? [];

        // If workouts are found for the category, map to Workout objects
        if (workoutsJson.isNotEmpty) {
          List<Workout> workouts = workoutsJson.map((json) => Workout.fromJson(json)).toList();
          emit(WorkoutLoaded(workouts)); // Emit loaded state with the workouts
        } else {
          emit(WorkoutError('No workouts available for this category.'));
        }
      } else {
        // Handle HTTP error
        emit(WorkoutError('Failed to load workouts. Status Code: ${response.statusCode}'));
      }
    } catch (e) {
      // Catch any unexpected errors
      print('Error occurred: $e');
      emit(WorkoutError('Failed to load workouts due to an error: $e'));
    }
  }
}
