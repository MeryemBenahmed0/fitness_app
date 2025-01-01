import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/workout_bloc.dart';
import 'package:test_app/component/workout_card.dart';
import 'package:test_app/screens/details_screen.dart';

class WorkoutsPage extends StatelessWidget {
  final int categoryId;

  WorkoutsPage({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workouts')),
      body: BlocProvider(
        create: (context) => WorkoutBloc()..add(FetchWorkouts(categoryId)),
        child: BlocBuilder<WorkoutBloc, WorkoutState>(
          builder: (context, state) {
            if (state is WorkoutLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WorkoutLoaded) {
              return ListView.builder(
                itemCount: state.workouts.length,
                itemBuilder: (context, index) {
                  final workout = state.workouts[index];
                  return WorkoutCard(
                    workout: workout,
                    onViewDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WorkoutDetailsPage(workout: workout),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is WorkoutError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('No workouts found.'));
            }
          },
        ),
      ),
    );
  }
}
