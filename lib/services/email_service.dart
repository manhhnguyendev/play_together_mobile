import 'package:play_together_mobile/helpers/api_url.dart' as apiUrl;
import 'package:play_together_mobile/helpers/config_json.dart' as configJson;
import 'dart:async';
import 'package:http/http.dart';

class EmailService {
  Future<String?> checkEmail(String email) async {
    Response response;
    String? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.accounts}/check-exist-email?email=$email'),
        headers: configJson.headerAuth(email),
      );
      if (response.statusCode == 200) {
        result = response.body;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
