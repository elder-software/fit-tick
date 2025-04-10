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
    on<InitialEvent>(_onInitialEvent);
    on<UpdateWorkout>(_onUpdateWorkout);
    on<DeleteWorkout>(_onDeleteWorkout);
    on<DeleteExercise>(_onDeleteExercise);
    on<LoadExercises>(_onLoadExercises);
  }

  void _onLoadScreen(LoadScreen event, Emitter<WorkoutState> emit) async {
    try {
      final workout = await _workoutRepo.readWorkout(event.workoutId);
      final exercises = await _exerciseRepo.allExercisesForWorkout(
        event.workoutId,
      );
      emit(
        WorkoutLoaded(
          workout: workout,
          exercises: exercises,
          exercisesLoading: false,
        ),
      );
    } catch (e) {
      print(e);
      emit(ErrorScreen(message: 'Error loading workout.'));
    }
  }

  void _onInitialEvent(InitialEvent event, Emitter<WorkoutState> emit) {
    emit(Initial());
  }

  Future<void> _onUpdateWorkout(
    UpdateWorkout event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      await _workoutRepo.updateWorkout(event.workout);
      if (state is WorkoutLoaded) {
        final currentState = state as WorkoutLoaded;
        emit(
          WorkoutLoaded(
            workout: event.workout,
            exercises: currentState.exercises,
            exercisesLoading: currentState.exercisesLoading,
          ),
        );
      } else {
        add(LoadScreen(workoutId: event.workout.id));
      }
    } catch (e) {
      print(e);
      emit(ErrorScreen(message: 'Error updating workout.'));
    }
  }

  Future<void> _onDeleteWorkout(
    DeleteWorkout event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      await _workoutRepo.deleteWorkout(event.workoutId);
      emit(Initial());
    } catch (e) {
      print(e);
      emit(ErrorScreen(message: 'Error deleting workout.'));
    }
  }

  Future<void> _onDeleteExercise(
    DeleteExercise event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      if (state is WorkoutLoaded) {
        final currentState = state as WorkoutLoaded;
        emit(
          WorkoutLoaded(
            workout: currentState.workout,
            exercises: currentState.exercises,
            exercisesLoading: true,
          ),
        );
      } else {
        add(LoadScreen(workoutId: event.workoutId));
      }
      await _exerciseRepo.deleteExercise(event.workoutId, event.exerciseId);
      add(LoadScreen(workoutId: event.workoutId));
    } catch (e) {
      print(e);
      emit(ErrorScreen(message: 'Error deleting exercise.'));
    }
  }

  Future<void> _onLoadExercises(
    LoadExercises event,
    Emitter<WorkoutState> emit,
  ) async {
    if (state is WorkoutLoaded) {
      final currentState = state as WorkoutLoaded;
      emit(
        WorkoutLoaded(
          workout: currentState.workout,
          exercises: currentState.exercises,
          exercisesLoading: true,
        ),
      );
    } else {
      add(LoadScreen(workoutId: event.workout.id));
      return;
    }
    try {
      final exercises = await _exerciseRepo.allExercisesForWorkout(
        event.workout.id,
      );
      emit(
        WorkoutLoaded(
          workout: event.workout,
          exercises: exercises,
          exercisesLoading: false,
        ),
      );
    } catch (e) {
      print(e);
      emit(ErrorScreen(message: 'Error loading exercises.'));
    }
  }
}
