import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/game_of_user_model.dart';

class GameOfUserService {
  Future<bool?> updateGameOfUser(String gameOfUserId,
      UpdateGameOfUserModel updateGameOfUserModel, dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${apiUrl.gameOfUser}/$gameOfUserId'),
        headers: configJson.headerAuth(token),
        body: jsonEncode(updateGameOfUserModel.toJson()),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> deleteGameOfUser(String gameOfUserId, dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await delete(
        Uri.parse('${apiUrl.gameOfUser}/$gameOfUserId'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> createGameOfUser(
      List<CreateGameOfUserModel> createGameOfUserModel, dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await post(
        Uri.parse('${apiUrl.gameOfUser}/multi-games'),
        headers: configJson.headerAuth(token),
        body: json.encoder.convert(createGameOfUserModel),
      );
      if (response.statusCode == 200) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
