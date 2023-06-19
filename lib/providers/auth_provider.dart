import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surgery_tracker/constants/storage_keys.dart';
import 'package:surgery_tracker/models/auth_user.dart';

import '../models/app_user.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../utils/utils.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  AuthUser user = AuthUser();
  String confirmPassword = '';
  bool get isAuthenticated => _isAuthenticated;

  Future<bool> login() async {
    _isAuthenticated = true;
    notifyListeners();
    Response? loginResponse = await AuthService.login(user);
    if (loginResponse != null) {
      Map loginResBody = jsonDecode(loginResponse.body);
      if (!loginResBody.containsKey('code')) {
        debugPrint(loginResponse.body.toString());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(StorageKeys.sessionID, loginResBody["\$id"]);
        prefs.setString(StorageKeys.userId, loginResBody["userId"]);
        return true;
      } else {
        debugPrint(loginResponse.body.toString());
        return false;
      }
    } else {
      debugPrint(loginResponse?.body.toString());
      return false;
    }
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<bool> register() async {
    setUserId(null);
    Response? response = await AuthService.register(user);
    if (response != null) {
      setDocumentId(null);
      Map res = jsonDecode(response.body);
      debugPrint(response.body.toString());
      if (!res.containsKey('code') && res['status']) {
        response = await UserService.addUser(user.appUser);
        if (response != null) {
          debugPrint(jsonEncode(response.body));
          user = AuthUser();
          notifyListeners();
          return true;
        } else {
          return false;
        }
      } else {
        debugPrint("${res["message"]} ${res["code]"]}");
        return false;
      }
    } else {
      debugPrint("Error$response");
      return false;
    }
  }

  void setAppUser(AppUser appUser) {
    user.appUser = appUser;
  }

  void setEmail(String email) {
    user.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    user.password = password;
    notifyListeners();
  }

  void setFirstName(String firstName) {
    user.appUser.firstName = firstName;
    notifyListeners();
  }

  void setLastName(String lastName) {
    user.appUser.lastName = lastName;
    notifyListeners();
  }

  void setSpecialization(String specialization) {
    user.appUser.specialization = specialization;
    notifyListeners();
  }

  void setName(String name) {
    user.name = name;
    notifyListeners();
  }

  void setImageUrl(String imageUrl) {
    user.appUser.imageUrl = imageUrl;
    notifyListeners();
  }

  void setUserId(String? userId) {
    if (userId == null) {
      user.userId = Utils.generateRandomID();
      user.appUser.userId = user.userId;
    } else {
      user.userId = userId;
    }
    user.appUser.userId = user.userId;
    notifyListeners();
  }

  void setDocumentId(String? docId) {
    if (docId == null) {
      user.appUser.documentID = Utils.generateRandomID();
    } else {
      user.appUser.documentID = docId;
    }
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword) {
    this.confirmPassword = confirmPassword;
    notifyListeners();
  }
}
