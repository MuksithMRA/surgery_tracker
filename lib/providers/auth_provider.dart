import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surgery_tracker/constants/storage_keys.dart';
import 'package:surgery_tracker/models/auth_user.dart';
import 'package:surgery_tracker/models/error_model.dart';

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
        Response? userResponse = await UserService.getUsers();
        if (userResponse != null) {
          List<dynamic> userResponseBody =
              jsonDecode(userResponse.body)["documents"];
          var user = userResponseBody.firstWhere(
              (element) => element['userId'] == loginResBody['userId']);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(StorageKeys.sessionID, loginResBody["\$id"]);
          prefs.setString(StorageKeys.userId, loginResBody["userId"]);
          prefs.setString(StorageKeys.profilePic, user["profileImage"]);
          return true;
        } else {
          return false;
        }
      } else {
        ErrorModel.errorMessage = loginResBody['message'];
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    _isAuthenticated = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response? response = await AuthService.destroySession(
        prefs.getString(StorageKeys.sessionID)!);
    if (response != null) {
      debugPrint(response.body);
      await prefs.remove(StorageKeys.sessionID);
      await prefs.remove(StorageKeys.userId);
      await prefs.remove(StorageKeys.profilePic);
    }
    notifyListeners();
    return true;
  }

  Future<bool> register(BuildContext context) async {
    setUserId();
    Response? response = await AuthService.register(user);
    if (response != null) {
      setDocumentId();
      Map res = jsonDecode(response.body);
      if (!res.containsKey('code') && res['status']) {
        setName();
        setProfileImage();
        response = await UserService.addUser(user.appUser);
        if (response != null) {
          Map<String, dynamic> responseBody = jsonDecode(response.body);
          if (!res.containsKey('code')) {
            user = AuthUser();
            notifyListeners();
            return true;
          } else {
            ErrorModel.errorMessage = responseBody['message'];
            return false;
          }
        } else {
          return false;
        }
      } else {
        ErrorModel.errorMessage = res['message'];
        return false;
      }
    } else {
      return false;
    }
  }

  void setAuthUser(AuthUser authUser) {
    user = authUser;
  }

  void setEmail(String email) {
    user.email = email;
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

  void setImageUrl(String imageUrl) {
    user.appUser.imageUrl = imageUrl;
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

  void setDocumentId({String? docId}) {
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
