import '../models/entity_model.dart';
import 'enviornment.dart';

class ApiEndPoint {
  static const registerWithEmail = "/account";
  static String getDatabaseEndpoint(EntityModel collection) {
    return "/databases/${Enviornment.databaseID}/collections/${collection.code}/documents";
  }
}
