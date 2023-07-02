import 'package:flutter/cupertino.dart';
import 'package:surgery_tracker/models/surgery_model.dart';
import 'package:surgery_tracker/services/surgery_services.dart';

class SurgeryProvider extends ChangeNotifier {
  List<SurgeryModel> surgeries = [];
  List<SurgeryModel> searchResult = [];
  SurgeryModel surgeryModel = SurgeryModel();
  String surgeryText = "";

  Future<bool> getAllSurgeries() async {
    return await SurgeryServices.getAllSurgeries().then((value) {
      if (value != null) {
        surgeries = value.docs.map((e) {
          SurgeryModel surgeryModel = SurgeryModel.fromMap(e.data());
          surgeryModel.documentID = e.id;
          return surgeryModel;
        }).toList();
        searchSurgries("");
        notifyListeners();
        return true;
      } else {
        return false;
      }
    });
  }

  Future<bool> saveSurgery() async {
    bool success = false;
    await SurgeryServices.addSurgery(surgeryModel).then(
      (value) async {
        success = value;
        if (success) {
          await getAllSurgeries();
        }
      },
    );
    notifyListeners();
    return success;
  }

  Future<bool> deleteSurgery(String documentID) async {
    bool success = false;
    await SurgeryServices.deleteSurgery(documentID).then(
      (value) async {
        success = value;
        if (success) {
          await getAllSurgeries();
        }
      },
    );
    notifyListeners();
    return success;
  }

  Future<bool> editSurgery() async {
    bool success = false;
    await SurgeryServices.editSurgery(surgeryModel).then(
      (value) async {
        success = value;
      },
    );
    notifyListeners();
    return success;
  }

  void searchSurgries(String searchText) {
    if (searchText.isNotEmpty) {
      searchResult = surgeries
          .where((element) =>
              element.consultantName.toLowerCase().contains(searchText) ||
              element.surgeryName.toLowerCase().contains(searchText))
          .toList();
    } else {
      searchResult = surgeries;
    }
    notifyListeners();
  }

  setSurgery(SurgeryModel surgery) {
    surgeryModel = surgery;
  }

  seUserId(String userId) {
    surgeryModel.userId = userId;
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
