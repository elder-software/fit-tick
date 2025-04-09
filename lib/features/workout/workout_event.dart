part of 'workout_bloc.dart';

class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object> get props => [];
}

class LoadScreen extends WorkoutEvent {
  final String workoutId;
  const LoadScreen({required this.workoutId});

  @override
  List<Object> get props => [workoutId];
}
