import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  final String id;
  final String userId;
  final String name;

  Workout({required this.id, required this.userId, required this.name});

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    // id is not included in the JSON as it is either auto-generated or provided in the function it's used in
    return {'userId': userId, 'name': name};
  }

  factory Workout.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Workout(
      id: doc.id,
      userId: data['userId'] ?? '',
      name: data['name'] ?? '',
    );
  }

  Workout copyWith({String? id, String? userId, String? name}) {
    return Workout(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
    );
  }
}
