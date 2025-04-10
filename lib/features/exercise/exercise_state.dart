part of 'exercise_bloc.dart';

class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object?> get props => [];
}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoaded extends ExerciseState {
  final Exercise? exercise;
  final String workoutId;
  final bool isSaving;

  const ExerciseLoaded(this.exercise, this.workoutId, {this.isSaving = false});

  @override
  List<Object?> get props => [exercise, workoutId, isSaving];
}

class ExerciseSaveSuccess extends ExerciseState {}

class ExerciseError extends ExerciseState {
  final String message;

  const ExerciseError(this.message);

  @override
  List<Object?> get props => [message];
}
