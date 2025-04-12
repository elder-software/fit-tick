import 'package:flutter/material.dart';

class TimerControls extends StatelessWidget {
  const TimerControls({
    super.key,
    required this.onSkipPrevious,
    required this.onPauseToggle,
    required this.onSkipNext,
    required this.isRunning,
  });

  final VoidCallback onSkipPrevious;
  final VoidCallback onPauseToggle;
  final VoidCallback onSkipNext;
  final bool isRunning;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.colorScheme.onSurface;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.skip_previous, color: iconColor),
            iconSize: 28.0,
            onPressed: onSkipPrevious,
            tooltip: 'Skip Previous',
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(
                isRunning ? Icons.pause : Icons.play_arrow,
                color: iconColor,
              ),
              iconSize: 36.0,
              onPressed: onPauseToggle,
              tooltip: isRunning ? 'Pause' : 'Play',
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.skip_next, color: iconColor),
            iconSize: 28.0,
            onPressed: onSkipNext,
            tooltip: 'Skip Next',
          ),
        ],
      ),
    );
  }
}
