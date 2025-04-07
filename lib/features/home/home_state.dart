part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Workout> workouts;

  const HomeLoaded({required this.workouts});

  @override
  List<Object> get props => [workouts];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});
}
