import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_tick_mobile/data/workout/workout.dart';

class WorkoutRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addWorkout(Workout workout) async {
    await _firestore
        .collection('workouts')
        .doc()
        .set(workout.toJson());
  }

  Future<List<Workout>> allWorkoutsForUser(String userIdForQuery) async {
    final workouts =
        await FirebaseFirestore.instance
            .collection('workouts')
            .where('userId', isEqualTo: userIdForQuery)
            .get();
    return workouts.docs.map((doc) => Workout.fromFirestore(doc)).toList();
  }
}
