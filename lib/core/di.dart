import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_tick_mobile/data/auth/auth_service.dart'; // Adjust the import path if necessary
import 'package:fit_tick_mobile/data/workout/workout_repo.dart';
import 'package:fit_tick_mobile/features/home/home_bloc.dart'; // Import HomeBloc

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final workoutRepoProvider = Provider<WorkoutRepo>((ref) {
  return WorkoutRepo();
});

final homeBlocProvider = Provider<HomeBloc>((ref) {
  final authService = ref.read(authServiceProvider);
  final workoutRepo = ref.read(workoutRepoProvider);
  final bloc = HomeBloc(authService: authService, workoutRepo: workoutRepo);
  bloc.add(LoadWorkouts()); 
  return bloc;
});
