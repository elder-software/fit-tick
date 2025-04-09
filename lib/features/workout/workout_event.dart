part of 'workout_bloc.dart';

class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends WorkoutEvent {}

class LoadScreen extends WorkoutEvent {
  final String workoutId;
  const LoadScreen({required this.workoutId});

  @override
  List<Object> get props => [workoutId];
}

class WorkoutError extends WorkoutEvent {
  final String message;
  const WorkoutError({required this.message});

  @override
  List<Object> get props => [message];
}
