import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc() : super(TimerInitial()) {
    on<TimerStarted>(_onTimerStarted);
  }

  void _onTimerStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunning());
  }
}
