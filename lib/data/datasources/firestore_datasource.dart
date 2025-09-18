import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/notes.dart';

class FirestoreDatasource {
  final collection = FirebaseFirestore.instance.collection("notes");

  //CREATE NOTES
  Future<void> addNote(Notes note) async {
    try {
      await collection.doc(note.id).set(note.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Notes>> getNotes() async {
    List<Notes> notesList = [];
    try {
      final snapshot = await collection.get();

      for (var doc in snapshot.docs) {
        final note = Notes.fromMap(doc.data(), doc.id);
        notesList.add(note);
      }
      return notesList;
    } catch (e) {
      log(e.toString());
      return notesList = [];
    }
  }
}
