import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:surgery_tracker/models/surgery_model.dart';

import '../models/error_model.dart';

class SurgeryServices {
  static final _surgeries = FirebaseFirestore.instance.collection('surgeries');
  static final _currentUser = FirebaseAuth.instance.currentUser!;

  static Future<QuerySnapshot<Map<String, dynamic>>?> getAllSurgeries() async {
    QuerySnapshot<Map<String, dynamic>>? documentSnapshot;
    try {
      documentSnapshot = await _surgeries.get();
    } on FirebaseException catch (e) {
      ErrorModel.errorMessage = e.message!;
    } on Exception catch (e) {
      ErrorModel.errorMessage = e.toString();
    }
    return documentSnapshot;
  }

  static Future<bool> addSurgery(SurgeryModel surgery) async {
    try {
      surgery.userId = _currentUser.uid;
      await _surgeries.add(surgery.toMap());
      return true;
    } on FirebaseException catch (e) {
      ErrorModel.errorMessage = e.message!;
    } on Exception catch (e) {
      ErrorModel.errorMessage = e.toString();
    }
    return false;
  }

  static Future<bool> deleteSurgery(String surgeryId) async {
    try {
      return await _surgeries.doc(surgeryId).delete().then((value) {
        return true;
      });
    } on FirebaseException catch (e) {
      ErrorModel.errorMessage = e.message!;
    } on Exception catch (e) {
      ErrorModel.errorMessage = e.toString();
    }
    return false;
  }

  static Future<bool> editSurgery(SurgeryModel model) async {
    try {
      await _surgeries.doc(model.documentID).update(model.toMap());
      return true;
    } on FirebaseException catch (e) {
      ErrorModel.errorMessage = e.message!;
    } on Exception catch (e) {
      ErrorModel.errorMessage = e.toString();
    }
    return false;
  }
}
