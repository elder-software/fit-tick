import 'package:fit_tick_mobile/data/exercise/exercise.dart';
import 'package:flutter/material.dart';

class WorkoutExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final Function() onMoreOptionsPressed;
  const WorkoutExerciseCard({
    super.key,
    required this.exercise,
    required this.onMoreOptionsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  color: theme.colorScheme.primaryContainer,
                  child: Text(
                    '${exercise.exerciseTime}s Ex.',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: theme.colorScheme.secondaryContainer,
                  child: Text(
                    '${exercise.restTime}s Rest',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSecondaryContainer,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exercise.name, style: theme.textTheme.titleMedium),
                Text(
                  exercise.description ?? 'No description',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: onMoreOptionsPressed,
          ),
        ],
      ),
    );
  }
}
