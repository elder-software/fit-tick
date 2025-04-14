import 'dart:async';
import 'package:fit_tick_mobile/features/timer/timer_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tick_mobile/data/exercise/exercise.dart';
import 'package:fit_tick_mobile/features/timer/timer_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
  bool _isRestPhase = false;
  int _currentDuration = 0;
  late FlutterTts flutterTts;

  bool _isTransitioningFromRest = false;

  // Flag to prevent auto-start on initial load
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
    _currentBackgroundColor = Colors.transparent;
    _currentForegroundColor = Colors.transparent;
    flutterTts = FlutterTts();
    _setupTts();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TimerBloc>().add(TimerReset());

      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final exercises = args?['exercises'] as List<Exercise>?;
      if (exercises != null) {
        context.read<TimerBloc>().add(TimerInitialized(exercises: exercises));
      }
    });
  }

  Future<void> _setupTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    flutterTts.stop();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _toggleTimer() {
    if (_isRunning) {
      _pauseTimer();
    } else {
      final currentState = context.read<TimerBloc>().state;
      if (currentState is TimerStandard) {
        _speak(_isRestPhase ? "Rest" : currentState.currentExercise.name);
      }
      _startTimer();
    }

    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    _updateColors();

    _animationController.duration = Duration(seconds: _currentDuration);
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

  void _updateColors() {
    if (_isTransitioningFromRest) return;

    final theme = Theme.of(context);
    if (_isRestPhase) {
      _currentBackgroundColor = theme.colorScheme.primary;
      _currentForegroundColor = theme.colorScheme.secondary;
    } else {
      _currentBackgroundColor = theme.colorScheme.secondary;
      _currentForegroundColor = theme.colorScheme.primary;
    }
  }

  void _handleTimerComplete() {
    setState(() {
      _isRunning = false;
    });

    if (_isRestPhase) {
      _isTransitioningFromRest = true;
      _isRestPhase = false;
      context.read<TimerBloc>().add(TimerNextExercise());
    } else {
      final currentState = context.read<TimerBloc>().state;
      if (currentState is TimerStandard &&
          currentState.currentExercise.restTime != null) {
        setState(() {
          _isRestPhase = true;
          _currentDuration = currentState.currentExercise.restTime!;
        });

        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            _speak("Rest");
            _toggleTimer();
          }
        });
      } else {
        context.read<TimerBloc>().add(TimerNextExercise());
      }
    }
  }

  void _skipPrevious() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isRestPhase = false;
      _isTransitioningFromRest = false;
    });
    context.read<TimerBloc>().add(TimerPreviousExercise());
  }

  void _skipNext() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isRestPhase = false;
      _isTransitioningFromRest = false;
    });
    context.read<TimerBloc>().add(TimerNextExercise());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    if (_currentBackgroundColor == Colors.transparent) {
      _updateColors();
    }

    return BlocListener<TimerBloc, TimerState>(
      listener: (context, state) {
        if (state is TimerStandard) {
          setState(() {
            _isRestPhase = false;
            _currentDuration = state.currentExercise.exerciseTime ?? 0;
            if (!_isTransitioningFromRest) {
              _updateColors();
            } else {
              _isTransitioningFromRest = false;
            }
          });

          // Speak the exercise name when it starts (and not initial load)
          if (!_isInitialLoad && !_isRestPhase) {
            _speak(state.currentExercise.name);
          }

          // Auto-start timer if not initial load and not currently running
          if (!_isInitialLoad && !_isRunning) {
            _speak(_isRestPhase ? "Rest" : state.currentExercise.name);
            _toggleTimer();
          } else if (_isInitialLoad) {
            // Reset the flag after the first load
            _isInitialLoad = false;
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
                        _isRestPhase ? "Rest" : state.currentExercise.name,
                        style: textTheme.displayMedium?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _isRestPhase
                            ? 'Get ready for the next exercise'
                            : state.currentExercise.description ?? '',
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
