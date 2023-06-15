import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:surgery_tracker/models/app_user.dart';

import '../constants/api_endpoint.dart';
import '../constants/enviornment.dart';

class AuthService {
  login() async {
    await http.post(Uri.parse("${Enviornment.apiUrl}/account"), body: {});
  }

  Future<http.Response?> register(AppUser registerDto) async {
    try {
      return await http.post(
        Uri.parse("${Enviornment.apiUrl}${ApiEndPoint.registerWithEmailApi}"),
        body: jsonEncode(registerDto.toMap()),
      );
    } on Exception catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }
}
