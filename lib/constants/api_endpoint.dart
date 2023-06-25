import '../models/entity_model.dart';
import 'enviornment.dart';

class ApiEndPoint {
  static const sessions = "/account/sessions";
  static const buckets = "/storage/buckets";
  static const registerWithEmail = "/account";
  static const loginWithEmail = "$sessions/email";
  static const allUsers = "/users";

  static String getDatabaseEndpoint(EntityModel collection) {
    return "/databases/${Enviornment.databaseID}/collections/${collection.code}/documents";
  }
}
