import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_tick_mobile/data/exercise/exercise.dart';
import 'package:fit_tick_mobile/data/utils/lexicographical_indexing.dart';

class ExerciseRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _exercisesCollection(
    String workoutId,
  ) {
    return _firestore
        .collection('workouts')
        .doc(workoutId)
        .collection('exercises');
  }

  Future<void> createExercise(String workoutId, Exercise exercise) async {
    final exercises = await allExercisesForWorkout(workoutId);
    final String? lastIndex = exercises.isEmpty ? null : exercises.last.index;
    final newIndex = generateNextIndex(lastIndex);
    exercise = exercise.copyWith(index: newIndex);
    await _exercisesCollection(workoutId).doc().set(exercise.toJson());
  }

  Future<Exercise> readExercise(String workoutId, String exerciseId) async {
    final exerciseDoc =
        await _exercisesCollection(workoutId).doc(exerciseId).get();
    if (!exerciseDoc.exists) {
      throw Exception(
        "Exercise with ID $exerciseId not found in workout $workoutId",
      );
    }
    return Exercise.fromFirestore(exerciseDoc);
  }

  Future<List<Exercise>> allExercisesForWorkout(String workoutId) async {
    final snapshot =
        await _exercisesCollection(workoutId).orderBy('index').get();
    return snapshot.docs.map((doc) => Exercise.fromFirestore(doc)).toList();
  }

  Future<void> updateExercise(String workoutId, Exercise exercise) async {
    if (exercise.id.isEmpty) {
      throw ArgumentError("Exercise must have an ID to be updated.");
    }
    await _exercisesCollection(
      workoutId,
    ).doc(exercise.id).update(exercise.toJson());
  }

  Future<void> deleteExercise(String workoutId, String exerciseId) async {
    await _exercisesCollection(workoutId).doc(exerciseId).delete();
  }
}
