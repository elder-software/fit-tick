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

  factory Exercise.fromJson(Map<String, dynamic> json, String id) {
    return Exercise(
      id: id,
      name: json['name'],
      exerciseTime: json['exerciseTime'],
      restTime: json['restTime'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'exerciseTime': exerciseTime,
      'restTime': restTime,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory Exercise.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Exercise.fromJson(data, doc.id);
  }
}
