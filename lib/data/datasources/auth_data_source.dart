import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthDataSource {
  final auth = FirebaseAuth.instance;

  //SIGN UP
  Future<UserCredential?> signUp(String email, String password) async {
    try {
      final cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred;
    } on FirebaseAuthException catch (e) {
      log("Auth Exception in source signup ${e.message}");
    } catch (e) {
      log("Error in source signup $e");
    }

    return null;
  }

  //LOG IN
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      final cred = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred;
    } on FirebaseAuthException catch (e) {
      log("Auth Exception in source signin ${e.message} with code ${e.code}");
    } catch (e) {
      log("Error in source signin $e");
    }
    return null;
  }

  // SIGN OUT
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      log("Auth Exception in source signout ${e.message}");
    } catch (e) {
      log("Error in source signout $e");
    }
  }

  //GOOGLE SIGN IN
}
