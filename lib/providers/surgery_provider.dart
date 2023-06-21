import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surgery_tracker/constants/storage_keys.dart';
import 'package:surgery_tracker/models/surgery_model.dart';
import 'package:surgery_tracker/services/surgery_services.dart';
import 'package:surgery_tracker/utils/utils.dart';

class SurgeryProvider extends ChangeNotifier {
  List<SurgeryModel> surgeries = [];
  SurgeryModel surgeryModel = SurgeryModel();

  Future<bool> getAllSurgeries() async {
    Response? response = await SurgeryServices.getAllSurgeries();
    if (response != null && response.statusCode == 200) {
      List<dynamic> res = jsonDecode(response.body)['documents'];
      surgeries = res.map((e) => SurgeryModel.fromJson(jsonEncode(e))).toList();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> saveSurgery() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setDocumentId();
    await getAllSurgeries();
    int id = surgeries.last.id;
    setId(id += 1);
    setCurrentDate();
    seUserId(prefs.getString(StorageKeys.userId)!);
    Response? response = await SurgeryServices.addSurgery(surgeryModel);
    if (response != null && response.statusCode == 201) {
      var res = jsonDecode(response.body);
      debugPrint(response.body);
      return true;
    } else {
      return false;
    }
  }

  setDocumentId() {
    surgeryModel.documentID = Utils.generateRandomID();
    notifyListeners();
  }

  seUserId(String userId) {
    surgeryModel.userId = userId;
    notifyListeners();
  }

  setId(int id) {
    surgeryModel.id = id;
    notifyListeners();
  }

  setSurgeryName(String surgeryName) {
    surgeryModel.surgeryName = surgeryName;
    notifyListeners();
  }

  setBHTNumber(String bhtNumber) {
    surgeryModel.bht = bhtNumber;
    notifyListeners();
  }

  setConsultantName(String consultantName) {
    surgeryModel.consultantName = consultantName;
    notifyListeners();
  }

  setConsultantSpecialization(String consultantSpecialization) {
    surgeryModel.doneBy = consultantSpecialization;
    notifyListeners();
  }

  setCurrentDate() {
    surgeryModel.date = DateTime.now();
    notifyListeners();
  }
}
