import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
import 'package:play_together_mobile/models/game_of_user_model.dart';

class GameOfUserService {
  Future<bool?> updateGameOfUser(String gameOfUserId,
      UpdateGameOfUserModel updateGameOfUserModel, dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${api_url.gameOfUser}/$gameOfUserId'),
        headers: config_json.headerAuth(token),
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
        Uri.parse('${api_url.gameOfUser}/$gameOfUserId'),
        headers: config_json.headerAuth(token),
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
        Uri.parse('${api_url.gameOfUser}/multi-games'),
        headers: config_json.headerAuth(token),
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
