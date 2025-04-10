import 'package:bloc/bloc.dart';
import 'package:fit_tick_mobile/data/exercise/exercise_repo.dart';
import 'exercise_event.dart';
import 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepo _exerciseRepo;

  ExerciseBloc({required ExerciseRepo exerciseRepo})
      : _exerciseRepo = exerciseRepo,
        super(const ExerciseState()) {
    // TODO: Register event handlers here
  }

  // TODO: Add event handler methods
}
