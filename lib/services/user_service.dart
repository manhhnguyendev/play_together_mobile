import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/user_model.dart';

class UserService {
  Future<UserModel?> getUserProfile(dynamic token) async {
    Response response;
    UserModel? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}/personal'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = UserModel.fromJson(json.decode(response.body));
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

  Future<List<UserModel>?> getAllUsersIsNewAccount(dynamic token) async {
    Response response;
    List<UserModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}?IsNewAccount=true&PageNumber=0&PageSize=4'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body.map((dynamic item) => UserModel.fromJson(item)).toList();
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<List<UserModel>?> getAllUsersIsSameHobbies(dynamic token) async {
    Response response;
    List<UserModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}?IsSameHobbies=true&PageNumber=0&PageSize=4'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body.map((dynamic item) => UserModel.fromJson(item)).toList();
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<List<UserModel>?> getAllUsersIsOrderByRating(dynamic token) async {
    Response response;
    List<UserModel>? result;
    try {
      response = await get(
        Uri.parse(
            '${apiUrl.users}?IsOrderByRating=true&PageNumber=0&PageSize=4'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body.map((dynamic item) => UserModel.fromJson(item)).toList();
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<List<UserModel>?> getAllUsersIsRecentOrder(dynamic token) async {
    Response response;
    List<UserModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}?IsRecentOrder=true&PageNumber=0&PageSize=4'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body.map((dynamic item) => UserModel.fromJson(item)).toList();
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<UserModel?> getUserById(String userId, dynamic token) async {
    Response response;
    UserModel? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}/$userId'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = UserModel.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<PlayerModel?> getPlayerById(String id, dynamic token) async {
    Response response;
    PlayerModel? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}/$id'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = PlayerModel.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<UserServiceModel?> getUserServiceById(
      String userId, dynamic token) async {
    Response response;
    UserServiceModel? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}/service/$userId'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = UserServiceModel.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<List<GameOfUserModel>?> getGameOfUser(
      String userId, dynamic token) async {
    Response response;
    List<GameOfUserModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}/$userId/games'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => GameOfUserModel.fromJson(item)).toList();
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
