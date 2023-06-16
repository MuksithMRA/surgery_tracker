import 'dart:math';

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

  static String generateUserID() {
    const validChars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-_';
    const maxChars = 36;

    Random random = Random();
    String userID = '';
    String firstChar = validChars[random.nextInt(validChars.length)];
    userID += firstChar;
    for (int i = 0; i < maxChars - 1; i++) {
      String char = validChars[random.nextInt(validChars.length)];
      userID += char;
    }
    return userID;
  }
}
