import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:surgery_tracker/models/auth_user.dart';

import '../models/error_model.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> login(AuthUser authModel) async {
    try {
      UserCredential userCred = await _auth
          .signInWithEmailAndPassword(
            email: authModel.email,
            password: authModel.password,
          )
          .then((value) => value);

      return userCred.user?.uid != null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ErrorModel.errorMessage = 'No user found for this email.';
      } else if (e.code == 'wrong-password') {
        ErrorModel.errorMessage = 'Wrong password provided for this user.';
      } else {
        ErrorModel.errorMessage = e.message ?? '';
      }
    } on Exception catch (e) {
      ErrorModel.errorMessage = e.toString();
    }
    return false;
  }

  Future<AuthUser?> register(AuthUser authModel) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: authModel.email, password: authModel.password)
          .then((value) {
        debugPrint("User registered ${value.user!.uid}");
        authModel.userId = value.user!.uid;
        authModel.appUser.userId = authModel.userId;
      });
      return authModel;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ErrorModel.errorMessage = 'The account already exists for this email.';
      } else if (e.code == 'invalid-email') {
        ErrorModel.errorMessage = 'Invalid email address.';
      } else {
        ErrorModel.errorMessage = e.message ?? '';
      }
      return null;
    } on Exception catch (e) {
      ErrorModel.errorMessage = e.toString();
      return null;
    }
  }

  bool isLoggedIn() {
    _auth.userChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        debugPrint('User is signed in!');
      }
    });
    return _auth.currentUser != null;
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      ErrorModel.errorMessage = e.message ?? '';
      return false;
    } on Exception catch (e) {
      ErrorModel.errorMessage = e.toString();
      return false;
    }
  }

  static Future<void>? forgetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      ErrorModel.errorMessage = e.message ?? '';
      return;
    } on Exception catch (e) {
      ErrorModel.errorMessage = e.toString();
      return;
    }
  }
}
