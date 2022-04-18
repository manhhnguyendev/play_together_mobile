import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as apiUrl;
import 'package:play_together_mobile/helpers/config_json.dart' as configJson;
import 'package:play_together_mobile/models/rank_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';

class RankService {
  Future<ResponseModel<RankModel>?> getRankById(
      String id, dynamic token) async {
    Response response;
    ResponseModel<RankModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.ranks}/$id'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseModel<RankModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<RankModel>?> getAllRanksInGame(
      String gameId, dynamic token) async {
    Response response;
    ResponseListModel<RankModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.games}/$gameId/ranks'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseListModel<RankModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
