import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:surgery_tracker/models/surgery_model.dart';

import '../constants/api_endpoint.dart';
import '../constants/enviornment.dart';
import '../utils/utils.dart';

class SurgeryServices {
  static Future<Response?> getAllSurgeries() async {
    try {
      return await get(
        Uri.parse(
          "${Enviornment.apiUrl}${ApiEndPoint.getDatabaseEndpoint(Enviornment.surgeryCollection)}",
        ),
        headers: Utils.header(true),
      );
    } on Exception catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }

  static Future<Response?> deleteSurgery(String documentId) async {
    try {
      String api =
          "${Enviornment.apiUrl}${ApiEndPoint.getDatabaseEndpoint(Enviornment.surgeryCollection)}/$documentId";
      return await delete(
        Uri.parse(api),
        headers: Utils.header(true),
      );
    } on Exception catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }

  static Future<Response?> editSurgery(SurgeryModel model) async {
    try {
      String api =
          "${Enviornment.apiUrl}${ApiEndPoint.getDatabaseEndpoint(Enviornment.surgeryCollection)}/${model.documentID}";
      return await patch(
        Uri.parse(api),
        body: jsonEncode({
          "data": model.toJson(),
        }),
        headers: Utils.header(true),
      );
    } on Exception catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }

  static Future<Response?> addSurgery(SurgeryModel surgeryModel) async {
    try {
      return await post(
        Uri.parse(
          "${Enviornment.apiUrl}${ApiEndPoint.getDatabaseEndpoint(Enviornment.surgeryCollection)}",
        ),
        body: jsonEncode({
          "data": surgeryModel.toJson(),
          "documentId": surgeryModel.documentID
        }),
        headers: Utils.header(true),
      );
    } on Exception catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }
}
