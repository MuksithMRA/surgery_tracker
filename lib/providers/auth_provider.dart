import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:surgery_tracker/models/app_user.dart';

import '../models/auth_user.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';
import '../utils/utils.dart';

class AuthProvider extends ChangeNotifier {
  final bool _isAuthenticated = false;
  AuthUser user = AuthUser();
  AppUser appUser = AppUser();
  String confirmPassword = '';
  bool get isAuthenticated => _isAuthenticated;
  AuthService authService = AuthService();

  Future<bool> login() async {
    bool success = await authService.login(user).then((value) => value);
    if (success) {
      await getCurentUserModel();
    }
    return success;
  }

  Future<bool> register() async {
    return await authService.register(user).then(
      (value) {
        if (value != null) {
          user = value;
          UserService.addUser(user);
          return true;
        } else {
          return false;
        }
      },
    );
  }

  Future<bool> signOut() async {
    return await authService.signOut();
  }

  bool isLoggedIn() {
    return authService.isLoggedIn();
  }

  Future<AuthUser?> getCurentUserModel() async {
    if (authService.isLoggedIn()) {
      return await UserService.getCurentUser().then((value) {
        if (value != null) {
          Map<String, dynamic> user = value.docs.first.data();
          appUser = AppUser.fromMap(user);
          this.user.email = appUser.email;
          this.user.userId = appUser.userId;
          this.user.appUser = appUser;
          notifyListeners();
          return this.user;
        }
        return null;
      });
    }
    return null;
  }

  Future<bool> updateSingleField(String key, String value) async {
    return await UserService.updateSingleField(key, value)
        .then((success) async {
      if (success) {
        if (key == 'profilePic') {
          getCurrentUser()!.updatePhotoURL(value);
        }

        if (key == 'first_name' || key == 'last_name') {
          await getCurentUserModel();
          getCurrentUser()!
              .updateDisplayName("${appUser.firstName} ${appUser.lastName}");
          notifyListeners();
        }
        return true;
      } else {
        return false;
      }
    });
  }

  Future<void> forgetPassword(BuildContext context) async {
    await AuthService.forgetPassword(user.email);
  }

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  void setAuthUser(AuthUser authUser) {
    user = authUser;
  }

  void setEmail(String email) {
    user.email = email;
    user.appUser.email = email;
    notifyListeners();
  }

  void setProfileImage({File? profileImage}) async {
    profileImage ??= File("assets/images/doctor_avatar.png");
    String profileImageBase64 = await Utils.imageToBase64(profileImage);
    user.appUser.profileImage = profileImageBase64;
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

  void setName({String? name}) {
    name ??= "${user.appUser.firstName} ${user.appUser.lastName}";
    user.name = name;
    notifyListeners();
  }

  void setUserId({String? userId}) {
    if (userId == null) {
      user.userId = Utils.generateRandomID();
      user.appUser.userId = user.userId;
    } else {
      user.userId = userId;
    }
    user.appUser.userId = user.userId;
    notifyListeners();
  }

  void setConfirmPassword(String confirmPassword) {
    this.confirmPassword = confirmPassword;
    notifyListeners();
  }
}
