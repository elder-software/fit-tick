part of 'exercise_bloc.dart';

abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();

  @override
  List<Object?> get props => [];
}

class InitExercise extends ExerciseEvent {
  final String workoutId;
  final String? exerciseId;

  const InitExercise({required this.workoutId, this.exerciseId});
}

class SaveExercise extends ExerciseEvent {
  final String workoutId;
  final Exercise exercise;

  const SaveExercise({required this.workoutId, required this.exercise});
}
