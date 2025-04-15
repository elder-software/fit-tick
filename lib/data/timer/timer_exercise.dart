class TimerExercise {
  final String id;
  final String name;
  final String description;
  final int time;
  final TimerExerciseType type;

  TimerExercise({
    required this.id,
    required this.name,
    required this.description,
    required this.time,
    required this.type,
  });
}

enum TimerExerciseType { exercise, rest, roundRest }
