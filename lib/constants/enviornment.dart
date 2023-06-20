import '../models/entity_model.dart';

class Enviornment {
  static const apiUrl = "https://cloud.appwrite.io/v1";
  static const projectID = "648739213aeae95cc9c1";
  static const apiKey =
      "98aec2de86ba24306e750b4322ab98c37e8acdbf0d6861f12e1065e5b84a7245443e55e6f4f2f9fc6593af3c64510f3271278432234984bd3470e0399fb06d8ed5878d6fb5989385d5ec12faef783959d5b9841a3f9259720f23e897142dde84f9e8ece45a0e6cdfbee5df6c7c8b44c4ecc04bb59b169146854a93221facb049";
  static const String jsonContentType = "application/json";
  static const String databaseID = "648c7addbf7fb733e7ea";
  static const String userBucketID = "6491cdcf38955d6d3506";

  static final EntityModel userCollection = EntityModel(
    name: "users",
    code: "648c7b31156552300e20",
  );
}
