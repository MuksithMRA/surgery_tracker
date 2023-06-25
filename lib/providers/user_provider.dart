import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/storage_keys.dart';
import '../models/app_user.dart';
import '../services/user_service.dart';
import '../utils/utils.dart';

class UserProvider extends ChangeNotifier {
  AppUser user = AppUser();
  Image? profilePic;
  Image? tempProfilePic;
  File? tempProfilePicFile;

  Future<bool> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response? response = await UserService.getUsers();
    if (response != null && response.statusCode == 200) {
      List<dynamic> res = jsonDecode(response.body)['documents'];
      if (res.any((element) =>
          element['userId'] == prefs.getString(StorageKeys.userId))) {
        user = AppUser.fromJson(jsonEncode(res.firstWhere((element) =>
            element['userId'] == prefs.getString(StorageKeys.userId))));
        await prefs.setString(StorageKeys.profilePic, user.profileImage);
        notifyListeners();
      }
      return true;
    } else {
      return false;
    }
  }

  getProfilePic() async {
    await SharedPreferences.getInstance().then((pref) async {
      String base64 = pref.getString(StorageKeys.profilePic) ?? '';
      profilePic = await Utils.base64ToImage(base64);
      notifyListeners();
    });
  }

  Future<bool> editUser() async {
    Response? response = await UserService.editUser(user);
    if (response != null && response.statusCode == 200) {
      debugPrint(response.body);
      await getUser();
      await getProfilePic();
      return true;
    } else {
      debugPrint(response?.body);
      return false;
    }
  }

  setTempProfilePic(Image profilePic) {
    tempProfilePic = profilePic;
    notifyListeners();
  }

  setTempProfilePicFile(File file) {
    tempProfilePicFile = file;
    notifyListeners();
  }

  setProfilePic() async {
    user.profileImage = await Utils.imageToBase64(tempProfilePicFile!);
    notifyListeners();
  }

  setFirstName(String firstName) {
    user.firstName = firstName;
    notifyListeners();
  }

  setLastName(String lastName) {
    user.lastName = lastName;
    notifyListeners();
  }

  setSpecialization(String specialization) {
    user.specialization = specialization;
    notifyListeners();
  }
}
