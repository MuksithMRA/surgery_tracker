import 'package:http/http.dart' as http;

import '../constants/enviornment.dart';

class AuthService {
  login() async {
    await http.post(Uri.parse("${Enviornment.apiUrl}/account"), body: {});
  }
}
