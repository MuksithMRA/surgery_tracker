import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:surgery_tracker/models/app_user.dart';
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
}
