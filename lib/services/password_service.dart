import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as apiUrl;
import 'package:play_together_mobile/helpers/config_json.dart' as configJson;
import 'package:play_together_mobile/models/password_model.dart';
import 'package:play_together_mobile/models/token_model.dart';

class PasswordService {
  Future<bool?> resetPassword(ResetPasswordModel resetPasswordModel) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${apiUrl.accounts}/reset-password'),
        headers: configJson.header(),
        body: jsonEncode(resetPasswordModel.toJson()),
      );
      if (response.statusCode == 200) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<TokenModel?> resetPasswordToken(EmailModel emailModel) async {
    Response response;
    TokenModel? result;
    try {
      response = await put(
        Uri.parse('${apiUrl.accounts}/reset-password-token'),
        headers: configJson.header(),
        body: jsonEncode(emailModel.toJson()),
      );
      if (response.statusCode == 200) {
        result = TokenModel.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> changePassword(
      ChangePasswordModel changePasswordModel, dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${apiUrl.accounts}/change-password'),
        headers: configJson.headerAuth(token),
        body: jsonEncode(changePasswordModel.toJson()),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
