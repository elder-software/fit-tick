import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_tick_mobile/data/exercise/exercise.dart';
import 'package:fit_tick_mobile/data/exercise/exercise_repo.dart';
import 'package:fit_tick_mobile/data/workout/workout.dart';
import 'package:fit_tick_mobile/data/workout/workout_repo.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final WorkoutRepo _workoutRepo;
  final ExerciseRepo _exerciseRepo;

  WorkoutBloc({
    required WorkoutRepo workoutRepo,
    required ExerciseRepo exerciseRepo,
  }) : _workoutRepo = workoutRepo,
       _exerciseRepo = exerciseRepo,
       super(Initial()) {
    on<LoadScreen>(_onLoadScreen);
  }

  void _onLoadScreen(LoadScreen event, Emitter<WorkoutState> emit) async {
    try {
      final workout = await _workoutRepo.readWorkout(event.workoutId);
      final exercises = await _exerciseRepo.allExercisesForWorkout(
        event.workoutId,
      );
      emit(WorkoutLoaded(workout: workout, exercises: exercises));
    } catch (e) {
      print(e);
      emit(WorkoutError(message: 'Error loading workout.'));
    }
  }
}
