import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surgery_tracker/constants/enviornment.dart';
import 'package:surgery_tracker/constants/storage_keys.dart';
import 'package:surgery_tracker/models/app_user.dart';
import 'package:surgery_tracker/services/storage_service.dart';
import 'package:surgery_tracker/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  AppUser user = AppUser();

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

  Future<bool> getProfilePic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response? response = await StorageService.getFileFromBucket(
        Enviornment.userBucketID, prefs.getString(StorageKeys.profilePicID)!);
    if (response != null) {
      debugPrint(jsonDecode(response.body).runtimeType.toString());
    }
    return true;
  }
}
