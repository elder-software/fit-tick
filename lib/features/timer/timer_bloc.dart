import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_tick_mobile/data/exercise/exercise.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(TimerInitial()) {
    on<TimerStarted>(_onTimerStarted);
    on<TimerInitialized>(_onTimerInitialized);
  }

  void _onTimerStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunning());
  }

  void _onTimerInitialized(TimerInitialized event, Emitter<TimerState> emit) {
    emit(TimerReady(exercises: event.exercises));
  }
}
