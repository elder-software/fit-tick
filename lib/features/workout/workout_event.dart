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

class UpdateWorkout extends WorkoutEvent {
  final Workout workout;
  const UpdateWorkout({required this.workout});

  @override
  List<Object> get props => [workout];
}

class DeleteWorkout extends WorkoutEvent {
  final String workoutId;
  const DeleteWorkout({required this.workoutId});

  @override
  List<Object> get props => [workoutId];
}

class DeleteExercise extends WorkoutEvent {
  final String workoutId;
  final String exerciseId;
  const DeleteExercise({required this.workoutId, required this.exerciseId});

  @override
  List<Object> get props => [workoutId, exerciseId];
}

class LoadExercises extends WorkoutEvent {
  final String workoutId;
  final Workout workout;
  const LoadExercises({required this.workoutId, required this.workout});

  @override
  List<Object> get props => [workoutId, workout];
}

class ShowTransientError extends WorkoutEvent {
  final String message;
  const ShowTransientError({required this.message});

  @override
  List<Object> get props => [message];
}
