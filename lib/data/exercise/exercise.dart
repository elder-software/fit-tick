import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_tick_mobile/data/timer/timer_exercise.dart';

class Exercise {
  final String id;
  final String name;
  final int? exerciseTime;
  final int? restTime;
  final String? description;
  final String? imageUrl;

  Exercise({
    required this.id,
    required this.name,
    this.exerciseTime,
    this.restTime,
    this.description,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    // id is not included in the JSON as it is either auto-generated or provided in the function it's used in
    return {
      'name': name,
      'exerciseTime': exerciseTime,
      'restTime': restTime,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory Exercise.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Exercise(
      id: doc.id,
      name: data['name'],
      exerciseTime: data['exerciseTime'],
      restTime: data['restTime'],
      description: data['description'],
      imageUrl: data['imageUrl'],
    );
  }
}

List<TimerExercise> buildTimerExercises(
  List<Exercise> exercises,
  int numberOfRounds,
  int roundRestTime,
) {
  final timerExercisesOneRound = <TimerExercise>[];

  for (final exercise in exercises) {
    if (exercise.exerciseTime != null && exercise.exerciseTime != 0) {
      timerExercisesOneRound.add(
        TimerExercise(
          id: exercise.id,
          name: exercise.name,
          time: exercise.exerciseTime!,
          description: exercise.description ?? '',
          type: TimerExerciseType.exercise,
        ),
      );
    }
    if (exercise.restTime != null && exercise.restTime != 0) {
      timerExercisesOneRound.add(
        TimerExercise(
          id: exercise.id,
          name: 'Rest',
          time: exercise.restTime!,
          description: 'Take a break',
          type: TimerExerciseType.rest,
        ),
      );
    }
  }

  final timerExercises = <TimerExercise>[];
  for (var i = 0; i < numberOfRounds; i++) {
    timerExercises.addAll(timerExercisesOneRound);
    if (i < numberOfRounds - 1) {
      timerExercises.add(
        TimerExercise(
          id: 'round-break',
          name: 'Round Break',
          time: roundRestTime,
          description: 'Take a break',
          type: TimerExerciseType.roundRest,
        ),
      );
    }
  }
  return timerExercises;
}
