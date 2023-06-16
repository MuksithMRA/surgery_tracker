import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:surgery_tracker/models/app_user.dart';
import 'package:surgery_tracker/utils/utils.dart';

import '../constants/api_endpoint.dart';
import '../constants/enviornment.dart';

class AuthService {
  login() async {
    await http.post(Uri.parse("${Enviornment.apiUrl}/account"), body: {});
  }

  static Future<http.Response?> register(AppUser registerDto) async {
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
}
