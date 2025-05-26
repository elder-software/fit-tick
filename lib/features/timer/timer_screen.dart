import 'dart:async';
import 'package:fit_tick_mobile/data/timer/timer_exercise.dart';
import 'package:fit_tick_mobile/features/timer/timer_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tick_mobile/features/timer/timer_bloc.dart';
import 'package:fit_tick_mobile/core/tts_service.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  Timer? _timer;
  bool _isRunning = false;
  int _currentDuration = 0;
  late TtsService _ttsService;

  bool _isInitialLoad = true;

  late Color _currentBackgroundColor;
  late Color _currentForegroundColor;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _currentForegroundColor = Colors.transparent;
    _currentBackgroundColor = Colors.transparent;
    _ttsService = TtsService();
    _ttsService.initialize();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final theme = Theme.of(context);
      setState(() {
        _currentForegroundColor = theme.colorScheme.secondary;
      });

      context.read<TimerBloc>().add(TimerReset());

      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final exercises = args?['exercises'] as List<TimerExercise>?;
      if (exercises != null) {
        context.read<TimerBloc>().add(TimerInitialized(exercises: exercises));
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    _ttsService.stop();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _toggleTimer() {
    final currentState = context.read<TimerBloc>().state;

    if (_isRunning) {
      _pauseTimer();
    } else {
      if (currentState is TimerStandard) {
        _ttsService.speak(currentState.currentExercise.name);
        _startTimer(currentState.currentExercise);
      }
    }

    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void _startTimer(TimerExercise timerExercise) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _animationController.duration = Duration(seconds: timerExercise.time);
    _animationController.reset();
    _animationController.forward();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentDuration > 0) {
        setState(() {
          _currentDuration--;
        });
      } else {
        _timer?.cancel();
        _handleTimerComplete();
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    _animationController.stop();
  }

  void _updateColors(TimerExercise timerExercise) {
    final theme = Theme.of(context);
    _currentBackgroundColor = _currentForegroundColor;
    _currentForegroundColor = switch (timerExercise.type) {
      TimerExerciseType.rest => theme.colorScheme.secondary,
      TimerExerciseType.exercise => theme.colorScheme.primary,
      TimerExerciseType.roundRest => theme.colorScheme.tertiaryFixedDim,
    };
  }

  void _handleTimerComplete() {
    setState(() {
      _isRunning = false;
    });

    context.read<TimerBloc>().add(TimerNextExercise());
  }

  void _skipPrevious() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
    context.read<TimerBloc>().add(TimerPreviousExercise());
  }

  void _skipNext() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
    context.read<TimerBloc>().add(TimerNextExercise());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return BlocListener<TimerBloc, TimerState>(
      listener: (context, state) {
        if (state is TimerStandard) {
          _updateColors(state.currentExercise);
          setState(() {
            _currentDuration = state.currentExercise.time;
          });

          if (!_isInitialLoad && !_isRunning) {
            _toggleTimer();
          } else if (_isInitialLoad) {
            _isInitialLoad = false;
          }

          // Announce next exercise during rest phases, after current exercise is announced
          if (!_isInitialLoad && 
              (state.currentExercise.type == TimerExerciseType.rest || 
               state.currentExercise.type == TimerExerciseType.roundRest)) {
            final nextIndex = state.currentExerciseIndex + 1;
            if (nextIndex < state.exercises.length) {
              final nextExercise = state.exercises[nextIndex];
              // Delay to let current exercise announcement finish first
              Timer(const Duration(seconds: 2), () {
                _ttsService.speak("Next: ${nextExercise.name}");
              });
            }
          }
        }
      },
      child: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          if (state is TimerStandard) {
            return Stack(
              children: [
                Container(color: _currentBackgroundColor),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: _animationController.value,
                        child: child,
                      ),
                    );
                  },
                  child: Container(color: _currentForegroundColor),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 64),
                          child: IconButton.outlined(
                            icon: Icon(
                              Icons.close,
                              color: theme.colorScheme.onSurface,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: IconButton.styleFrom(
                              side: BorderSide(
                                color: theme.colorScheme.onSurface,
                              ),
                              backgroundColor: theme.colorScheme.surface,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        state.currentExercise.name,
                        style: textTheme.displayMedium?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.currentExercise.description,
                        style: textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Text(
                        _formatDuration(Duration(seconds: _currentDuration)),
                        style: textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 32.0),
                          child: TimerControls(
                            isRunning: _isRunning,
                            onPauseToggle: _toggleTimer,
                            onSkipPrevious: _skipPrevious,
                            onSkipNext: _skipNext,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
