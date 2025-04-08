part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class CreateWorkout extends HomeEvent {
  final String name;

  const CreateWorkout({required this.name});

  @override
  List<Object> get props => [name];
}

class LoadWorkouts extends HomeEvent {}

class _WorkoutsUpdated extends HomeEvent {
  final List<Workout> workouts;

  const _WorkoutsUpdated(this.workouts);

  @override
  List<Object> get props => [workouts];
}

class DeleteWorkout extends HomeEvent {
  final String workoutId;

  const DeleteWorkout({required this.workoutId});

  @override
  List<Object> get props => [workoutId];
}

class UpdateWorkout extends HomeEvent {
  final Workout workout;

  const UpdateWorkout({required this.workout});
}
