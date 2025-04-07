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
