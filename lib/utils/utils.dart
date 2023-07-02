import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:surgery_tracker/providers/auth_provider.dart';
import 'package:surgery_tracker/widgets/util_widgets.dart';

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

  static Future<Image> xFileToImage(XFile xFile) async {
    final Uint8List bytes = await xFile.readAsBytes();
    return Image.memory(bytes);
  }

  static Future pickImage(ImageSource source, BuildContext context) async {
    try {
      AuthProvider pUser = context.read<AuthProvider>();
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: source,
      );

      if (pickedFile != null) {
        // pUser.setTempProfilePicFile(File(pickedFile.path));
        await Utils.xFileToImage(pickedFile).then(
          (value) => {
            //  pUser.setTempProfilePic(value),
          },
        );
      }
    } on Exception catch (e) {
      UtilWidgets.showSnackBar(context, "Error: $e", true);
    }
  }

  static DateTime date(String value, String? format) {
    format ??= "dd/MM/YYYY";
    String key = format.contains('/') ? '/' : '-';
    List<String> items = value.split(key);

    if (items[0].length == 1) {
      items[0] = '0${items[0]}';
    }

    if (items[1].length == 1) {
      items[1] = '0${items[1]}';
    }

    if (items[2].length == 1) {
      items[2] = '0${items[2]}';
    }

    if (format.substring(0, 3) == 'dd$key' ||
        format.substring(0, 2) == 'd$key') {
      return DateTime.parse('${items[2]}-${items[1]}-${items[0]}');
    } else if (format.substring(0, 3) == 'mm$key' ||
        format.substring(0, 3) == 'MM$key' ||
        format.substring(0, 2) == 'M$key') {
      return DateTime.parse('${items[2]}-${items[0]}-${items[1]}');
    } else {
      return DateTime.parse('${items[0]}-${items[1]}-${items[2]}');
    }
  }
}
