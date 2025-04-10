import 'package:bloc/bloc.dart';
import 'package:fit_tick_mobile/data/exercise/exercise_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_tick_mobile/data/exercise/exercise.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepo _exerciseRepo;

  ExerciseBloc({required ExerciseRepo exerciseRepo})
    : _exerciseRepo = exerciseRepo,
      super(const ExerciseState()) {
    on<SaveExercise>(_onSaveExercise);
    on<InitExercise>(_onInitExercise);
  }

  Future<void> _onSaveExercise(
    SaveExercise event,
    Emitter<ExerciseState> emit,
  ) async {
    emit(ExerciseLoaded(event.exercise, event.workoutId, isSaving: true));
    try {
      if (event.exercise.id.isEmpty) {
        await _exerciseRepo.createExercise(event.workoutId, event.exercise);
      } else {
        await _exerciseRepo.updateExercise(event.workoutId, event.exercise);
      }
      emit(ExerciseSaveSuccess());
    } catch (e) {
      emit(ExerciseError(e.toString()));
    } finally {
      emit(ExerciseLoaded(event.exercise, event.workoutId, isSaving: false));
    }
  }

  Future<void> _onInitExercise(
    InitExercise event,
    Emitter<ExerciseState> emit,
  ) async {
    if (event.exerciseId == null) {
      emit(ExerciseLoaded(null, event.workoutId));
      return;
    }

    try {
      final exercise = await _exerciseRepo.readExercise(
        event.workoutId,
        event.exerciseId!,
      );
      emit(ExerciseLoaded(exercise, event.workoutId));
    } catch (e) {
      emit(ExerciseError(e.toString()));
    }
  }
}
