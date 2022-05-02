import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
import 'package:play_together_mobile/models/register_model.dart';

class RegisterService {
  Future<bool?> register(RegisterModel registerModel) async {
    Response response;
    bool? result;
    try {
      response = await post(
        Uri.parse('${api_url.accounts}/register-user'),
        headers: config_json.header(),
        body: jsonEncode(registerModel.toJson()),
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
