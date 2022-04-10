import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/game_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';

class GameService {
  Future<ResponseListModel<GamesModel>?> getAllGames(dynamic token) async {
    Response response;
    ResponseListModel<GamesModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.games}?PageSize=50'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseListModel<GamesModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<GamesModel>?> getMostFavoriteGames(
      dynamic token) async {
    Response response;
    ResponseListModel<GamesModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.games}?IsMostFavorite=true&PageSize=8'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseListModel<GamesModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
