import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../constants/enviornment.dart';

class Utils {
  static Map<String, String> header(bool withAuth) {
    Map<String, String> headers = {
      "X-Appwrite-Project": Enviornment.projectID,
      "Content-Type": Enviornment.jsonContentType,
    };
    if (withAuth) {
      headers.addAll({"X-Appwrite-Key": Enviornment.apiKey});
    }
    return headers;
  }

  static String generateRandomID() {
    const validChars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-_';
    const maxChars = 36;

    Random random = Random();
    String randomID = '';
    String firstChar = validChars[random.nextInt(validChars.length)];
    randomID += firstChar;
    for (int i = 0; i < maxChars - 1; i++) {
      String char = validChars[random.nextInt(validChars.length)];
      randomID += char;
    }
    return randomID;
  }

  static Future<String> imageToBase64(File image) async {
    Uint8List bytes = await image.readAsBytes();
    String base64Image = base64Encode(bytes);
    return base64Image;
  }

  static Future<Image> base64ToImage(String base64) async {
    Uint8List bytes = base64Decode(base64);
    return Image.memory(
      bytes,
      fit: BoxFit.fill,
    );
  }
}
