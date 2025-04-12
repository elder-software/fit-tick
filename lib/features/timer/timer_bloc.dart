import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_tick_mobile/data/exercise/exercise.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(TimerInitial()) {
    on<TimerStarted>(_onTimerStarted);
    on<TimerInitialized>(_onTimerInitialized);
    on<TimerNextExercise>(_onTimerNextExercise);
    on<TimerPreviousExercise>(_onTimerPreviousExercise);
  }

  void _onTimerStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(
      TimerStandard(
        exercises: event.exercises,
        currentExercise: event.exercises[event.currentExerciseIndex],
        currentExerciseIndex: event.currentExerciseIndex,
        isRunning: true,
      ),
    );
  }

  void _onTimerInitialized(TimerInitialized event, Emitter<TimerState> emit) {
    emit(
      TimerStandard(
        exercises: event.exercises,
        currentExercise: event.exercises[0],
        currentExerciseIndex: 0,
        isRunning: false,
      ),
    );
  }

  void _onTimerNextExercise(TimerNextExercise event, Emitter<TimerState> emit) {
    if (state is TimerStandard) {
      final currentState = state as TimerStandard;
      final newIndex = currentState.currentExerciseIndex + 1;
      if (newIndex < event.exercises.length) {
        emit(
          TimerStandard(
            exercises: currentState.exercises,
            currentExercise: currentState.exercises[newIndex],
            currentExerciseIndex: newIndex,
            isRunning: false,
          ),
        );
      }
    }
  }

  void _onTimerPreviousExercise(
    TimerPreviousExercise event,
    Emitter<TimerState> emit,
  ) {
    if (state is TimerStandard) {
      final currentState = state as TimerStandard;
      final newIndex = currentState.currentExerciseIndex - 1;
      if (newIndex >= 0) {
        emit(
          TimerStandard(
            exercises: event.exercises,
            currentExercise: event.exercises[newIndex],
            currentExerciseIndex: newIndex,
            isRunning: false,
          ),
        );
      }
    }
  }
}
