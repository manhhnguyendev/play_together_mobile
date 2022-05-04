import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
import 'package:play_together_mobile/models/charity_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';

class CharityService {
  Future<ResponseListModel<CharityModel>?> getAllCharities(
      dynamic token, int pageSize) async {
    Response response;
    ResponseListModel<CharityModel>? result;
    try {
      response = await get(
        Uri.parse('${api_url.charities}?IsActive=true&PageSize=$pageSize'),
        headers: config_json.headerAuth(token),
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
        Uri.parse('${api_url.charities}/$id'),
        headers: config_json.headerAuth(token),
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
