import 'dart:async';
import 'package:fit_tick_mobile/features/timer/timer_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tick_mobile/data/exercise/exercise.dart';
import 'package:fit_tick_mobile/features/timer/timer_bloc.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _wipeAnimation;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _wipeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final exercises = args?['exercises'] as List<Exercise>?;
      if (exercises != null) {
        context.read<TimerBloc>().add(TimerInitialized(exercises: exercises));
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
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
      _animationController.stop();
    } else {
      _animationController.forward();

      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_animationController.duration!.inSeconds > 0) {
          if (mounted) {
            setState(() {
              _animationController.duration =
                  _animationController.duration! - const Duration(seconds: 1);
            });
          } else {
            timer.cancel();
          }
        } else {
          timer.cancel();
          _animationController.stop();
          if (mounted) {
            setState(() {
              _isRunning = false;
            });
          }
        }
      });
    }
    if (mounted) {
      setState(() {
        _isRunning = !_isRunning;
      });
    }
  }

  void _skipPrevious() {}
  void _skipNext() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return BlocListener<TimerBloc, TimerState>(
      listener: (context, state) {
        if (state is TimerStandard) {
          _animationController.duration = Duration(
            seconds: state.currentExercise.exerciseTime!,
          );
        }
      },
      child: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          if (state is TimerStandard) {
            return Stack(
              children: [
                Container(color: theme.colorScheme.secondary),
                AnimatedBuilder(
                  animation: _wipeAnimation,
                  builder: (context, child) {
                    return ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: _wipeAnimation.value,
                        child: child,
                      ),
                    );
                  },
                  child: Container(color: theme.colorScheme.primary),
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
                        'Ensure back leg is straight\nTry not to tilt the pelvis forward',
                        style: textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Text(
                        _formatDuration(
                          _animationController.duration ?? Duration(seconds: 0),
                        ),
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
