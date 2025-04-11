part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerStarted extends TimerEvent {}

class TimerInitialized extends TimerEvent {
  final List<Exercise> exercises;

  const TimerInitialized({required this.exercises});
}
