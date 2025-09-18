import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app_firebase_flutter/data/datasources/auth_data_source.dart';

class AuthRepository {
  final source = AuthDataSource();

  Future<UserCredential?> signUp(String email, String password) async {
    try {
      return await source.signUp(email, password);
    } catch (e) {
      log("Error in Repo signup $e");
    }
    return null;
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      return await source.signIn(email, password);
    } catch (e) {
      log("Error in Repo signin $e");
    }
  }

  Future<void> signOut() async {
    try {
      await source.signOut();
    } catch (e) {
      log("Error in Repo signout $e");
    }
  }
}
