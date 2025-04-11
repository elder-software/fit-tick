part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  const TimerState();

  @override
  List<Object> get props => [];
}

class TimerInitial extends TimerState {}

class TimerRunning extends TimerState {}

class TimerReady extends TimerState {
  final List<Exercise> exercises;

  const TimerReady({required this.exercises});

  @override
  List<Object> get props => [exercises];
}
