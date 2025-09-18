class Notes {
  final String id;
  final String title;
  final String body;
  DateTime createdAt;

  Notes({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  factory Notes.fromMap(Map<String, dynamic> map, String docId) {
    return Notes(
      id: docId,
      title: map['title'],
      body: map['body'],
      createdAt: map['created_at'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
