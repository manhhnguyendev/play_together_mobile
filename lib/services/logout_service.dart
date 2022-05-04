import 'dart:async';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;

class LogoutService {
  Future<bool?> logout(dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${api_url.accounts}/logout'),
        headers: config_json.headerAuth(token),
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
