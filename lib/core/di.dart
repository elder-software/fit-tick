import 'package:fit_tick_mobile/data/exercise/exercise_repo.dart';
import 'package:fit_tick_mobile/features/timer/timer_bloc.dart';
import 'package:fit_tick_mobile/features/workout/workout_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_tick_mobile/data/auth/auth_service.dart'; // Adjust the import path if necessary
import 'package:fit_tick_mobile/data/workout/workout_repo.dart';
import 'package:fit_tick_mobile/features/home/home_bloc.dart'; // Import HomeBloc
import 'package:fit_tick_mobile/features/exercise/exercise_bloc.dart'; // Import ExerciseBloc
import 'package:fit_tick_mobile/features/account/account_bloc.dart'; // Import AccountBloc

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final workoutRepoProvider = Provider<WorkoutRepo>((ref) {
  return WorkoutRepo();
});

final exerciseRepoProvider = Provider<ExerciseRepo>((ref) {
  return ExerciseRepo();
});

final homeBlocProvider = Provider<HomeBloc>((ref) {
  return HomeBloc(
    authService: ref.read(authServiceProvider),
    workoutRepo: ref.read(workoutRepoProvider),
  );
});

final workoutBlocProvider = Provider<WorkoutBloc>((ref) {
  return WorkoutBloc(
    workoutRepo: ref.read(workoutRepoProvider),
    exerciseRepo: ref.read(exerciseRepoProvider),
  );
});

final exerciseBlocProvider = Provider<ExerciseBloc>((ref) {
  return ExerciseBloc(exerciseRepo: ref.read(exerciseRepoProvider));
});

final timerBlocProvider = Provider<TimerBloc>((ref) {
  return TimerBloc();
});

final accountBlocProvider = Provider<AccountBloc>((ref) {
  return AccountBloc(
    authService: ref.read(authServiceProvider),
    workoutRepo: ref.read(workoutRepoProvider),
  );
});
