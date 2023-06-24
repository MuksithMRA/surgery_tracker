import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:surgery_tracker/models/auth_user.dart';
import 'package:surgery_tracker/utils/utils.dart';

import '../constants/api_endpoint.dart';
import '../constants/enviornment.dart';

class AuthService {
  static Future<http.Response?> login(AuthUser authUser) async {
    try {
      return await http.post(
        Uri.parse("${Enviornment.apiUrl}${ApiEndPoint.loginWithEmail}"),
        body: authUser.toLoginJson(),
        headers: Utils.header(false),
      );
    } on Exception catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }

  static Future<http.Response?> register(AuthUser registerDto) async {
    try {
      return await http.post(
        Uri.parse("${Enviornment.apiUrl}${ApiEndPoint.registerWithEmail}"),
        body: registerDto.toJson(),
        headers: Utils.header(false),
      );
    } on Exception catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }

  static Future<http.Response?> destroySession(String sessionId) async {
    try {
      return await http.delete(
        Uri.parse("${Enviornment.apiUrl}${ApiEndPoint.sessions}/$sessionId"),
        headers: Utils.header(false),
      );
    } on Exception catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }

  static Future<http.Response?> verifyEmail(sessionId) async {
    try {
      return await http.delete(
        Uri.parse("${Enviornment.apiUrl}${ApiEndPoint.sessions}/$sessionId"),
        headers: Utils.header(false),
      );
    } on Exception catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }
}
