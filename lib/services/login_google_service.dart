import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as apiUrl;
import 'package:play_together_mobile/helpers/config_json.dart' as configJson;
import 'package:play_together_mobile/models/login_google_model.dart';
import 'package:play_together_mobile/models/token_model.dart';

class LoginGoogleService {
  Future<TokenModel?> loginGoogle(LoginGoogleModel loginGoogle) async {
    Response response;
    TokenModel? result;
    try {
      response = await post(
        Uri.parse('${apiUrl.accounts}/login-google'),
        headers: configJson.header(),
        body: jsonEncode(loginGoogle.toJson()),
      );
      if (response.statusCode == 200) {
        result = TokenModel.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
