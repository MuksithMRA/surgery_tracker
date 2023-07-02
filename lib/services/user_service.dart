import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:surgery_tracker/models/auth_user.dart';

import '../models/error_model.dart';

class UserService {
  static final User? authUser = FirebaseAuth.instance.currentUser;
  static final _users = FirebaseFirestore.instance.collection('users');
  static Future<bool> addUser(AuthUser user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc()
          .set(user.appUser.toMap());
      authUser!.updateDisplayName(
          "${user.appUser.firstName} ${user.appUser.lastName}");
      authUser!.updateEmail(user.email);
      return true;
    } on FirebaseException catch (e) {
      ErrorModel.errorMessage = e.message ?? '';
    } on Exception catch (e) {
      ErrorModel.errorMessage = e.toString();
    }
    return false;
  }

  static Future<QuerySnapshot<Map<String, dynamic>>?> getCurentUser() async {
    QuerySnapshot<Map<String, dynamic>>? result;
    try {
      result = await FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
    } on FirebaseException catch (e) {
      ErrorModel.errorMessage = e.message ?? '';
    } on Exception catch (e) {
      ErrorModel.errorMessage = e.toString();
    }
    return result;
  }

  static Future<bool> updateSingleField(String key, String value) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        value.docs.first.data().update(key, (val) => value);
      });

      return true;
    } on FirebaseException catch (e) {
      ErrorModel.errorMessage = e.message ?? '';
    } on Exception catch (e) {
      ErrorModel.errorMessage = e.toString();
    }
    return false;
  }

  static Future<bool> editUser(AuthUser model) async {
    try {
      await _users.doc(model.appUser.documentId).update(model.appUser.toMap());
      return true;
    } on FirebaseException catch (e) {
      ErrorModel.errorMessage = e.message!;
    } on Exception catch (e) {
      ErrorModel.errorMessage = e.toString();
    }
    return false;
  }

  static Future<QuerySnapshot<Map<String, dynamic>>?> getUserByUid(
      String uid) async {
    QuerySnapshot<Map<String, dynamic>>? result;
    try {
      result = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();
    } on FirebaseException catch (e) {
      ErrorModel.errorMessage = e.message ?? '';
    } on Exception catch (e) {
      ErrorModel.errorMessage = e.toString();
    }
    return result;
  }
}
