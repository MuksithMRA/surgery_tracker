import 'package:flutter/material.dart';
import 'package:surgery_tracker/services/user_service.dart';

import '../models/app_user.dart';
import '../services/auth_service.dart';
import '../utils/utils.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  AppUser appUser = AppUser();
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
    await AuthService.register(appUser).then((response) async {
      if (response != null) {
        setDocumentId(null);
        await UserService.addUser(appUser).then((response) {
          debugPrint(
              response?.body.toString() ?? "Error ${response?.statusCode}");
        });
      } else {
        debugPrint(
            response?.body.toString() ?? "Error ${response?.statusCode}");
      }
    });
    return true;
  }

  void setAppUser(AppUser appUser) {
    this.appUser = appUser;
  }

  void setEmail(String email) {
    appUser.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    appUser.password = password;
    notifyListeners();
  }

  void setFirstName(String firstName) {
    appUser.firstName = firstName;
    notifyListeners();
  }

  void setLastName(String lastName) {
    appUser.lastName = lastName;
    notifyListeners();
  }

  void setSpecialization(String specialization) {
    appUser.specialization = specialization;
    notifyListeners();
  }

  void setName(String name) {
    appUser.name = name;
    notifyListeners();
  }

  void setImageUrl(String imageUrl) {
    appUser.imageUrl = imageUrl;
    notifyListeners();
  }

  void setUserId(String? userId) {
    if (userId == null) {
      appUser.userId = Utils.generateUserID();
    } else {
      appUser.userId = userId;
    }
    notifyListeners();
  }

  void setDocumentId(String? docId) {
    if (docId == null) {
      appUser.documentID = Utils.generateUserID();
    } else {
      appUser.documentID = docId;
    }
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword) {
    this.confirmPassword = confirmPassword;
    notifyListeners();
  }
}
