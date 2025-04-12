part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  const TimerState();

  @override
  List<Object> get props => [];
}

class TimerInitial extends TimerState {}

class TimerStandard extends TimerState {
  final List<Exercise> exercises;
  final Exercise currentExercise;
  final int currentExerciseIndex;
  final bool isRunning;

  const TimerStandard({
    required this.exercises,
    required this.currentExercise,
    required this.currentExerciseIndex,
    required this.isRunning,
  });

  @override
  List<Object> get props => [
    currentExercise,
    currentExerciseIndex,
    isRunning,
    exercises,
  ];
}
