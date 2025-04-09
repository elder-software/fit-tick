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

  const WorkoutLoaded({required this.workout, required this.exercises});

  @override
  List<Object> get props => [workout, exercises];
}

class WorkoutError extends WorkoutState {
  final String message;

  const WorkoutError({required this.message});
}
