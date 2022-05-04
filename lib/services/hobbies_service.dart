import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
import 'package:play_together_mobile/models/hobbies_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';

class HobbiesService {
  Future<ResponseListModel<HobbiesModel>?> getHobbiesOfUser(
      String userId, dynamic token) async {
    Response response;
    ResponseListModel<HobbiesModel>? result;
    try {
      response = await get(
        Uri.parse('${api_url.users}/$userId/hobbies'),
        headers: config_json.headerAuth(token),
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
        Uri.parse(api_url.hobbies),
        headers: config_json.headerAuth(token),
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
        Uri.parse(api_url.hobbies),
        headers: config_json.headerAuth(token),
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
