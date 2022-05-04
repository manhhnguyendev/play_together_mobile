import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
import 'package:play_together_mobile/models/password_model.dart';
import 'package:play_together_mobile/models/token_model.dart';

class PasswordService {
  Future<bool?> resetPassword(ResetPasswordModel resetPasswordModel) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${api_url.accounts}/reset-password'),
        headers: config_json.header(),
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
        Uri.parse('${api_url.accounts}/reset-password-token'),
        headers: config_json.header(),
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
        Uri.parse('${api_url.accounts}/change-password'),
        headers: config_json.headerAuth(token),
        body: jsonEncode(changePasswordModel.toJson()),
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
