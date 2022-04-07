import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/game_model.dart';

class GameService {
  Future<List<GamesModel>?> getAllGames(dynamic token) async {
    Response response;
    List<GamesModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.games}/?PageSize=100'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body.map((dynamic item) => GamesModel.fromJson(item)).toList();
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
