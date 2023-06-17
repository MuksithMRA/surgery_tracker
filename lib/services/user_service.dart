import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/api_endpoint.dart';
import '../constants/enviornment.dart';
import '../models/app_user.dart';
import '../utils/utils.dart';

class UserService {
  static Future<http.Response?> addUser(AppUser userDTO) async {
    debugPrint(jsonEncode(
        {"data": userDTO.toJson(), "documentId": userDTO.documentID}));
    try {
      return await http.post(
        Uri.parse(
          "${Enviornment.apiUrl}${ApiEndPoint.getDatabaseEndpoint(Enviornment.userCollection)}",
        ),
        body: jsonEncode(
            {"data": userDTO.toJson(), "documentId": userDTO.documentID}),
        headers: Utils.header(true),
      );
    } on Exception catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }
}
