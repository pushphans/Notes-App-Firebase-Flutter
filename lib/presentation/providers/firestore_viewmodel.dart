import 'package:flutter/cupertino.dart';
import 'package:notes_app_firebase_flutter/data/models/notes.dart';
import 'package:notes_app_firebase_flutter/data/repositories/firestore_repository.dart';

class FireStoreViewModel extends ChangeNotifier {
  final repo = FireStoreRepository();

  List<Notes> _noteList = [];
  List<Notes> get noteList => _noteList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> addNote(Notes note) async {
    await repo.addNote(note);
  }

  Future<void> getNotes() async {
    _isLoading = true;
    notifyListeners();
    _noteList = await repo.getNotes();
    _isLoading = false;
    notifyListeners();
  }
}
