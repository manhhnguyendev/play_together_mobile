import 'dart:convert';

import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
import 'dart:async';
import 'package:http/http.dart';
import 'package:play_together_mobile/models/email_model.dart';

class EmailService {
  Future<String?> checkEmail(String email) async {
    Response response;
    String? result;
    try {
      response = await get(
        Uri.parse('${api_url.accounts}/check-exist-email?email=$email'),
        headers: config_json.headerAuth(email),
      );
      if (response.statusCode == 200) {
        result = response.body;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> sendEmail(SendEmailModel sendEmailModel, dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await post(
        Uri.parse('${api_url.email}/send'),
        headers: config_json.headerAuth(token),
        body: json.encoder.convert(sendEmailModel),
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
