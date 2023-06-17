import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:surgery_tracker/models/auth_user.dart';
import 'package:surgery_tracker/services/user_service.dart';

import '../models/app_user.dart';
import '../services/auth_service.dart';
import '../utils/utils.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  AuthUser user = AuthUser();
  String confirmPassword = '';
  bool get isAuthenticated => _isAuthenticated;

  void login() {
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<bool> register() async {
    setUserId(null);
    await AuthService.register(user).then((response) async {
      if (response != null) {
        setDocumentId(null);
        var res = jsonDecode(response.body);
        debugPrint(response.body.toString());
        if (res['code'] == 200) {
          user.appUser.userId = res['id'];
          await UserService.addUser(user.appUser).then((response) {
            debugPrint(
                response?.body.toString() ?? "Error ${response?.statusCode}");
            return true;
          });
        }
      } else {
        debugPrint(
            response?.body.toString() ?? "Error ${response?.statusCode}");
      }
    });
    return false;
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
