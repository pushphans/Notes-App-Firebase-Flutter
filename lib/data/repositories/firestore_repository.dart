import 'package:notes_app_firebase_flutter/data/datasources/firestore_datasource.dart';
import 'package:notes_app_firebase_flutter/data/models/notes.dart';

class FireStoreRepository {
  final source = FirestoreDatasource();

  Future<void> addNote(Notes note) async {
    await source.addNote(note);
  }

  Future<List<Notes>> getNotes() async {
    return await source.getNotes();
  }
}
