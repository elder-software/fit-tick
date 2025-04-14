part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object?> get props => [];
}

class TimerStarted extends TimerEvent {
  final List<Exercise> exercises;
  final int currentExerciseIndex;
  final int currentExerciseDuration;

  const TimerStarted({
    required this.exercises,
    required this.currentExerciseIndex,
    required this.currentExerciseDuration,
  });
}

class TimerInitialized extends TimerEvent {
  final List<Exercise> exercises;

  const TimerInitialized({required this.exercises});
}

class TimerNextExercise extends TimerEvent {}

class TimerPreviousExercise extends TimerEvent {}

class TimerReset extends TimerEvent {}
