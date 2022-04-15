import 'dart:async';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as apiUrl;
import 'package:play_together_mobile/helpers/config_json.dart' as configJson;

class LogoutService {
  Future<bool?> logout(dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${apiUrl.accounts}/logout'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
