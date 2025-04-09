import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String id;
  final String name;
  final int? time;
  final String? description;
  final String? imageUrl;

  Exercise({
    required this.id,
    required this.name,
    this.time,
    this.description,
    this.imageUrl,
  });

  factory Exercise.fromJson(Map<String, dynamic> json, String id) {
    return Exercise(
      id: id,
      name: json['name'],
      time: json['time'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'time': time,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory Exercise.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Exercise.fromJson(data, doc.id);
  }
}
