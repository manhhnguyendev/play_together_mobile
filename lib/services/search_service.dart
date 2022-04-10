import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/charity_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/user_model.dart';

class SearchService {
  Future<ResponseListModel<UserModel>?> searchUserByName(
      String search, dynamic token) async {
    Response response;
    ResponseListModel<UserModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}?Name=$search&IsPlayer=true'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseListModel<UserModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<UserModel>?> searchUser(
      String search, dynamic token) async {
    Response response;
    ResponseListModel<UserModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}?Search=$search&IsPlayer=true'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseListModel<UserModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<CharityModel>?> searchCharityByName(
      String search, dynamic token) async {
    Response response;
    ResponseListModel<CharityModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.charities}?Name=$search'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseListModel<CharityModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
