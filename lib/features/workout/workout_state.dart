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
  final String? transientErrorMessage;

  const WorkoutLoaded({
    required this.workout,
    required this.exercises,
    required this.exercisesLoading,
    this.transientErrorMessage,
  });

  @override
  List<Object> get props => [
    workout,
    exercises,
    exercisesLoading,
    if (transientErrorMessage != null) transientErrorMessage!,
  ];

  WorkoutLoaded copyWith({
    Workout? workout,
    List<Exercise>? exercises,
    bool? exercisesLoading,
    String? transientErrorMessage,
    bool clearTransientErrorMessage = false,
  }) {
    return WorkoutLoaded(
      workout: workout ?? this.workout,
      exercises: exercises ?? this.exercises,
      exercisesLoading: exercisesLoading ?? this.exercisesLoading,
      transientErrorMessage:
          clearTransientErrorMessage
              ? null
              : transientErrorMessage ?? this.transientErrorMessage,
    );
  }
}

class ErrorScreen extends WorkoutState {
  final String message;

  const ErrorScreen({required this.message});

  @override
  List<Object> get props => [message];
}
