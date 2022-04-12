import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/game_of_user_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/user_model.dart';

class UserService {
  Future<ResponseModel<UserModel>?> getUserProfile(dynamic token) async {
    Response response;
    ResponseModel<UserModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}/personal'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseModel<UserModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> updateUserProfile(
      UserUpdateModel userUpdateModel, dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${apiUrl.users}/personal'),
        headers: configJson.headerAuth(token),
        body: jsonEncode(userUpdateModel.toJson()),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<UserModel>?> getAllUsersIsNewAccount(
      dynamic token) async {
    Response response;
    ResponseListModel<UserModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}?IsNewAccount=true&IsPlayer=true&PageSize=4'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseListModel<UserModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<UserModel>?> getAllUsersIsSameHobbies(
      dynamic token) async {
    Response response;
    ResponseListModel<UserModel>? result;
    try {
      response = await get(
        Uri.parse(
            '${apiUrl.users}?IsSameHobbies=true&IsPlayer=true&PageSize=4'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseListModel<UserModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<UserModel>?> getAllUsersIsOrderByRating(
      dynamic token) async {
    Response response;
    ResponseListModel<UserModel>? result;
    try {
      response = await get(
        Uri.parse(
            '${apiUrl.users}?IsOrderByRating=true&IsPlayer=true&PageSize=4'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseListModel<UserModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<UserModel>?> getAllUsersIsRecentOrder(
      dynamic token) async {
    Response response;
    ResponseListModel<UserModel>? result;
    try {
      response = await get(
        Uri.parse(
            '${apiUrl.users}?IsRecentOrder=true&IsPlayer=true&PageSize=4'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseListModel<UserModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseModel<UserModel>?> getUserById(
      String userId, dynamic token) async {
    Response response;
    ResponseModel<UserModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}/$userId'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseModel<UserModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseModel<PlayerModel>?> getPlayerById(
      String id, dynamic token) async {
    Response response;
    ResponseModel<PlayerModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}/$id'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseModel<PlayerModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseModel<UserServiceModel>?> getUserServiceById(
      String userId, dynamic token) async {
    Response response;
    ResponseModel<UserServiceModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}/service/$userId'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseModel<UserServiceModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<GameOfUserModel>?> getGameOfUser(
      String userId, dynamic token) async {
    Response response;
    ResponseListModel<GameOfUserModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}/$userId/games?PageSize=50'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseListModel<GameOfUserModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> makeDonateToCharity(
      String charityId, dynamic token, MakeDonateModel model) async {
    Response response;
    bool? result;
    try {
      response = await post(
        Uri.parse('${apiUrl.users}/donates/$charityId'),
        headers: configJson.headerAuth(token),
        body: jsonEncode(model.toJson()),
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
