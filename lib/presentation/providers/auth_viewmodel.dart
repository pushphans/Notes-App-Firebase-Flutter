import 'package:flutter/foundation.dart';
import 'package:notes_app_firebase_flutter/data/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final repo = AuthRepository();

  Future<void> signUp(String email, String password) async {
    await repo.signUp(email, password);
  }

  Future<void> signIn(String email, String password) async {
    await repo.signIn(email, password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await repo.signOut();
    notifyListeners();
  }
}
