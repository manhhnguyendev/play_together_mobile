import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
import 'package:play_together_mobile/models/online_hour_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';

class DatingService {
  Future<ResponseListModel<OnlineHourModel>?> getAllDatings(
      String userId, dynamic token) async {
    Response response;
    ResponseListModel<OnlineHourModel>? result;
    try {
      response = await get(
        Uri.parse(
            '${api_url.users}/$userId/datings?PageSize=100&SortByDay=true'),
        headers: config_json.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseListModel<OnlineHourModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> createDating(
      CreateOnlineHourModel createOnlineHourModel, dynamic token) async {
    Response response;
    bool? result = false;
    try {
      response = await post(
        Uri.parse(api_url.dating),
        headers: config_json.headerAuth(token),
        body: json.encoder.convert(createOnlineHourModel),
      );
      if (response.statusCode == 200) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> updateDating(String datingId,
      UpdateOnlineHourModel updateOnlineHourModel, dynamic token) async {
    Response response;
    bool? result = false;
    try {
      response = await put(
        Uri.parse('${api_url.dating}/$datingId'),
        headers: config_json.headerAuth(token),
        body: json.encoder.convert(updateOnlineHourModel),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> deleteDating(String id, dynamic token) async {
    Response response;
    bool? result = false;
    try {
      response = await delete(
        Uri.parse('${api_url.dating}/$id'),
        headers: config_json.headerAuth(token),
        body: json.encoder.convert(id),
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
