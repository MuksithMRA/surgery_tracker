import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../constants/api_endpoint.dart';
import '../constants/enviornment.dart';
import '../utils/utils.dart';

class StorageService {
  static Future<Response?> getFileFromBucket(
      String bucketID, String fileID) async {
    try {
      return await get(
        Uri.parse(
            "${Enviornment.apiUrl}${ApiEndPoint.buckets}/$bucketID/files/$fileID"),
        headers: Utils.header(true),
      );
    } on Exception catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }
}
