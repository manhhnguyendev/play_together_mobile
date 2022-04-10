import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/hobbies_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';

class HobbiesService {
  Future<ResponseListModel<HobbiesModel>?> getHobbiesOfUser(
      String userId, dynamic token) async {
    Response response;
    ResponseListModel<HobbiesModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}/$userId/hobbies'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseListModel<HobbiesModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> createHobbies(
      List<CreateHobbiesModel> listCreateHobbies, dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await post(
        Uri.parse(apiUrl.hobbies),
        headers: configJson.headerAuth(token),
        body: json.encoder.convert(listCreateHobbies),
      );
      if (response.statusCode == 200) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> deleteHobbies(
      List<DeleteHobbiesModel> listDeleteHobbies, dynamic token) async {
    Response response;
    bool? result = false;
    try {
      response = await delete(
        Uri.parse(apiUrl.hobbies),
        headers: configJson.headerAuth(token),
        body: json.encoder.convert(listDeleteHobbies),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
