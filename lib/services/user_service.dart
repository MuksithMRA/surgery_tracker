import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:surgery_tracker/models/auth_user.dart';

import '../models/error_model.dart';

class UserService {
  static final User? authUser = FirebaseAuth.instance.currentUser;
  static Future<bool> addUser(AuthUser user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.userId)
          .set({
        'uid': user.userId,
        'first_name': user.appUser.firstName,
        'last_name': user.appUser.lastName,
        'email': user.email,
        'profilePic': user.appUser.profileImage,
      });
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
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({key: value});

      return true;
    } on FirebaseException catch (e) {
      ErrorModel.errorMessage = e.message ?? '';
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
