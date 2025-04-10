part of 'workout_bloc.dart';

abstract class WorkoutState extends Equatable {
  const WorkoutState();

  @override
  List<Object> get props => [];
}

class Initial extends WorkoutState {}

class WorkoutLoaded extends WorkoutState {
  final Workout workout;
  final List<Exercise> exercises;
  final bool exercisesLoading;

  const WorkoutLoaded({
    required this.workout,
    required this.exercises,
    required this.exercisesLoading,
  });

  @override
  List<Object> get props => [workout, exercises, exercisesLoading];
}

class ErrorScreen extends WorkoutState {
  final String message;

  const ErrorScreen({required this.message});
}
