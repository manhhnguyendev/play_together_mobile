import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
import 'package:play_together_mobile/models/login_google_model.dart';
import 'package:play_together_mobile/models/token_model.dart';

class LoginGoogleService {
  Future<TokenModel?> loginGoogle(LoginGoogleModel loginGoogle) async {
    Response response;
    TokenModel? result;
    try {
      response = await post(
        Uri.parse('${api_url.accounts}/login-google'),
        headers: config_json.header(),
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
