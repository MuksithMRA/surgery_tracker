import 'dart:convert';

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

  Future<bool> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response? response = await UserService.getUsers();
    if (response != null && response.statusCode == 200) {
      List<dynamic> res = jsonDecode(response.body)['documents'];
      if (res.any((element) =>
          element['userId'] == prefs.getString(StorageKeys.userId))) {
        user = AppUser.fromJson(jsonEncode(res.firstWhere((element) =>
            element['userId'] == prefs.getString(StorageKeys.userId))));
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
      //  var res = jsonDecode(response.body);
      debugPrint(response.body);
      await getUser();
      return true;
    } else {
      debugPrint(response?.body);
      return false;
    }
  }
}
