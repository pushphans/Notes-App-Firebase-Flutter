import 'package:cloud_firestore/cloud_firestore.dart';

class Notes {
  String title;
  String body;

  Timestamp createdAt;

  Notes({required this.title, required this.body, required this.createdAt});

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      title: map['title']! as String,
      body: map['body']! as String,
      createdAt: map['createdAt']! as Timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'body': body, 'createdAt': createdAt};
  }
}
