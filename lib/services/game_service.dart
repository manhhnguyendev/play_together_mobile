import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
import 'package:play_together_mobile/models/game_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';

class GameService {
  Future<ResponseListModel<GamesModel>?> getAllGames(dynamic token) async {
    Response response;
    ResponseListModel<GamesModel>? result;
    try {
      response = await get(
        Uri.parse('${api_url.games}?PageSize=50'),
        headers: config_json.headerAuth(token),
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
        Uri.parse('${api_url.games}?IsMostFavorite=true&PageSize=8'),
        headers: config_json.headerAuth(token),
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
