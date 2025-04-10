import 'package:cloud_firestore/cloud_firestore.dart';

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
