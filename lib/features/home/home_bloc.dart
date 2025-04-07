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

  HomeBloc({required AuthService authService, required WorkoutRepo workoutRepo})
    : _authService = authService,
      _workoutRepo = workoutRepo,
      super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is CreateWorkout) {
        emit(HomeLoading());
        try {
          final userId = _authService.currentUser?.uid;
          if (userId == null) {
            throw Exception('User not authenticated');
          }
          final workoutId = DateTime.now().millisecondsSinceEpoch.toString();

          final workout = Workout(
            id: workoutId,
            userId: userId,
            name: event.name,
          );

          await _workoutRepo.addWorkout(workout);
          emit(HomeLoaded(workouts: [workout]));
        } catch (e) {
          emit(HomeError(message: e.toString()));
        }
      } else if (event is LoadWorkouts) {
        emit(HomeLoading());
        try {
          final userId = _authService.currentUser?.uid;
          if (userId == null) {
            throw Exception('User not authenticated');
          }
          final workouts = await _workoutRepo.allWorkoutsForUser(userId);
          emit(HomeLoaded(workouts: workouts));
        } catch (e) {
          emit(HomeError(message: e.toString()));
        }
      }
    });
  }
}
