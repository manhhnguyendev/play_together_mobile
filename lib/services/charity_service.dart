import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/charity_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';

class CharityService {
  Future<ResponseListModel<CharityModel>?> getAllCharities(
      dynamic token) async {
    Response response;
    ResponseListModel<CharityModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.charities}?IsActive=true'),
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

  Future<ResponseModel<CharityModel>?> getCharityById(
      String id, dynamic token) async {
    Response response;
    ResponseModel<CharityModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.charities}/$id'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseModel<CharityModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
