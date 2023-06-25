import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:provider/provider.dart';
import 'package:surgery_tracker/models/email_client.dart';
import 'package:surgery_tracker/models/error_model.dart';
import 'package:surgery_tracker/providers/user_provider.dart';
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

  static int generateRandomCode() {
    Random rand = Random();
    return rand.nextInt(99999);
  }

  static Future<bool> sendVerificationEmail(
      {required String recipient,
      bool isOnRegister = true,
      required int code}) async {
    String username = EmailClient.email;
    String password = EmailClient.password;
    String title = 'Verfication code for surgery tracker';
    String content = '${'<p>Here is the code : $code'}</p>';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Surgery Tracker')
      ..recipients.add(recipient)
      ..subject = title
      ..html = content;

    try {
      final sendReport = await send(message, smtpServer);
      debugPrint('Message sent: $sendReport');
      return true;
    } on MailerException catch (e) {
      ErrorModel.errorMessage = 'Email not sent';
      debugPrint('Message not sent.${e.message}');
      for (var p in e.problems) {
        debugPrint('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }

  static Future<Image> xFileToImage(XFile xFile) async {
    final Uint8List bytes = await xFile.readAsBytes();
    return Image.memory(bytes);
  }

  static Future pickImage(ImageSource source, BuildContext context) async {
    try {
      UserProvider pUser = context.read<UserProvider>();
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: source,
      );

      if (pickedFile != null) {
        await Utils.xFileToImage(pickedFile).then(
          (value) => {
            pUser.setTempProfilePic(value),
          },
        );
      }
    } on Exception catch (e) {
      UtilWidgets.showSnackBar(context, "Error: $e", true);
    }
  }
}
