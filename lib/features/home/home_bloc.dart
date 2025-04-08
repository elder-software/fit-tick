import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_tick_mobile/data/workout/workout.dart';
import 'package:fit_tick_mobile/data/auth/auth_service.dart';
import 'package:fit_tick_mobile/data/workout/workout_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthService _authService;
  final WorkoutRepo _workoutRepo;
  StreamSubscription<List<Workout>>? _workoutSubscription;

  HomeBloc({required AuthService authService, required WorkoutRepo workoutRepo})
    : _authService = authService,
      _workoutRepo = workoutRepo,
      super(HomeInitial()) {
    on<LoadWorkouts>(_onLoadWorkouts);
    on<_WorkoutsUpdated>(_onWorkoutsUpdated);
    on<CreateWorkout>(_onCreateWorkout);
    on<DeleteWorkout>(_onDeleteWorkout);
    on<UpdateWorkout>(_onUpdateWorkout);
  }

  void _onLoadWorkouts(LoadWorkouts event, Emitter<HomeState> emit) {
    final userId = _authService.currentUser?.uid;
    if (userId == null) {
      emit(const HomeError(message: 'User not authenticated'));
      return;
    }

    emit(HomeLoading());
    _workoutSubscription?.cancel();
    _workoutSubscription = _workoutRepo
        .allWorkoutsForUser(userId)
        .listen(
          (workouts) {
            add(_WorkoutsUpdated(workouts));
          },
          onError: (error) {
            emit(HomeError(message: error.toString()));
          },
        );
  }

  void _onWorkoutsUpdated(_WorkoutsUpdated event, Emitter<HomeState> emit) {
    emit(HomeLoaded(workouts: event.workouts));
  }

  Future<void> _onCreateWorkout(
    CreateWorkout event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final userId = _authService.currentUser?.uid;
      if (userId == null) {
        emit(const HomeError(message: 'Error creating workout'));
        return;
      }
      final workout = Workout(userId: userId, name: event.name);
      await _workoutRepo.createWorkout(workout);
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> _onDeleteWorkout(
    DeleteWorkout event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await _workoutRepo.deleteWorkout(event.workoutId);
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> _onUpdateWorkout(
    UpdateWorkout event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await _workoutRepo.updateWorkout(event.workout);
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _workoutSubscription?.cancel();
    return super.close();
  }
}
