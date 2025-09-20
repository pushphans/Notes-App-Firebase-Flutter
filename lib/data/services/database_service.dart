import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app_firebase_flutter/data/models/notes.dart';

const String _noteReferenceName = "notes";

class DatabaseService {
  late final CollectionReference _noteRef;

  DatabaseService() {
    _noteRef = FirebaseFirestore.instance
        .collection(_noteReferenceName)
        .withConverter<Notes>(
          fromFirestore: (snapshots, _) => Notes.fromMap(snapshots.data()!),
          toFirestore: (note, _) => note.toMap(),
        );
  }

  Stream<QuerySnapshot> getNotes() {
    return _noteRef.snapshots();
  }

  void addNote(Notes note) async {
    _noteRef.add(note);
  }

  void updateNote(String id, Notes note) async {
    _noteRef.doc(id).update(note.toMap());
  }

  void deleteNote(String id) async{
    _noteRef.doc(id).delete();
  }
}
