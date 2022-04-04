import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/user_model.dart';

class SearchService {
  Future<List<UserModel>?> searchUserByName(
      String search, dynamic token) async {
    Response response;
    List<UserModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}?Name=$search'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body.map((dynamic item) => UserModel.fromJson(item)).toList();
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<List<UserModel>?> searchUser(String search, dynamic token) async {
    Response response;
    List<UserModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}?Search=$search'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body.map((dynamic item) => UserModel.fromJson(item)).toList();
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
