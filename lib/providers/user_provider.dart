import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surgery_tracker/constants/storage_keys.dart';
import 'package:surgery_tracker/models/app_user.dart';
import 'package:surgery_tracker/services/user_service.dart';
import 'package:surgery_tracker/utils/utils.dart';

class UserProvider extends ChangeNotifier {
  AppUser user = AppUser();
  Image? profilePic;

  Future<bool> getUser() async {
    Response? response = await UserService.getUsers();
    if (response != null && response.statusCode == 200) {
      var res = jsonDecode(response.body);
      debugPrint(response.body);
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

  // Future<bool> getProfilePic() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Response? response = await StorageService.getFileFromBucket(
  //       Enviornment.userBucketID, prefs.getString(StorageKeys.profilePicID)!);
  //   if (response != null) {
  //     debugPrint(jsonDecode(response.body).runtimeType.toString());
  //   }
  //   return true;
  // }
}
