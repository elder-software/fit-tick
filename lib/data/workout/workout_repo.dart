import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_tick_mobile/data/workout/workout.dart';

class WorkoutRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createWorkout(Workout workout) async {
    await _firestore.collection('workouts').doc().set(workout.toJson());
  }

  Future<Workout> readWorkout(String workoutId) async {
    final workout =
        await _firestore.collection('workouts').doc(workoutId).get();
    return Workout.fromFirestore(workout);
  }

  Stream<List<Workout>> allWorkoutsForUser(String userIdForQuery) {
    return FirebaseFirestore.instance
        .collection('workouts')
        .where('userId', isEqualTo: userIdForQuery)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Workout.fromFirestore(doc))
              .toList();
        });
  }

  Future<List<Workout>> allWorkoutsForUserAsList(String userIdForQuery) async {
    final workouts =
        await FirebaseFirestore.instance
            .collection('workouts')
            .where('userId', isEqualTo: userIdForQuery)
            .get();
    return workouts.docs.map((doc) => Workout.fromFirestore(doc)).toList();
  }

  Future<void> updateWorkout(Workout workout) async {
    await _firestore
        .collection('workouts')
        .doc(workout.id)
        .update(workout.toJson());
  }

  Future<void> deleteWorkout(String workoutId) async {
    await _firestore.collection('workouts').doc(workoutId).delete();
  }

  Future<void> deleteAllWorkoutsForUser(String userId) async {
    final WriteBatch batch = _firestore.batch();
    final QuerySnapshot workoutsSnapshot =
        await _firestore
            .collection('workouts')
            .where('userId', isEqualTo: userId)
            .get();

    for (final doc in workoutsSnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}
