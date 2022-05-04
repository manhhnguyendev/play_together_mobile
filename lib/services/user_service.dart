import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
import 'package:play_together_mobile/models/game_of_user_model.dart';
import 'package:play_together_mobile/models/image_model.dart';
import 'package:play_together_mobile/models/momo_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/user_balance_model.dart';
import 'package:play_together_mobile/models/user_model.dart';

class UserService {
  Future<ResponseModel<UserModel>?> getUserProfile(dynamic token) async {
    Response response;
    ResponseModel<UserModel>? result;
    try {
      response = await get(
        Uri.parse('${api_url.users}/personal'),
        headers: config_json.headerAuth(token),
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
        Uri.parse('${api_url.users}/personal'),
        headers: config_json.headerAuth(token),
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

  Future<ResponseListModel<GetAllUserModel>?> getAllUsersIsNewAccount(
      dynamic token) async {
    Response response;
    ResponseListModel<GetAllUserModel>? result;
    try {
      response = await get(
        Uri.parse(
            '${api_url.users}?IsNewAccount=true&IsPlayer=true&PageSize=5'),
        headers: config_json.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseListModel<GetAllUserModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<GetAllUserModel>?> getAllUsersIsSkillSameHobbies(
      dynamic token) async {
    Response response;
    ResponseListModel<GetAllUserModel>? result;
    try {
      response = await get(
        Uri.parse(
            '${api_url.users}?IsSkillSameHobbies=true&IsPlayer=true&PageSize=5'),
        headers: config_json.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseListModel<GetAllUserModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<GetAllUserModel>?> getAllUsersIsOrderByRating(
      dynamic token) async {
    Response response;
    ResponseListModel<GetAllUserModel>? result;
    try {
      response = await get(
        Uri.parse('${api_url.users}?IsOrderByRating=true&PageSize=5'),
        headers: config_json.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseListModel<GetAllUserModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<GetAllUserModel>?> getAllUsersIsRecentOrder(
      dynamic token) async {
    Response response;
    ResponseListModel<GetAllUserModel>? result;
    try {
      response = await get(
        Uri.parse(
            '${api_url.users}?IsRecentOrder=true&IsPlayer=true&PageSize=5'),
        headers: config_json.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseListModel<GetAllUserModel>.fromJson(
            json.decode(response.body));
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
        Uri.parse('${api_url.users}/$userId'),
        headers: config_json.headerAuth(token),
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
        Uri.parse('${api_url.users}/$id'),
        headers: config_json.headerAuth(token),
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

  Future<ResponseModel<GetAllUserModel>?> getPlayerRecommendById(
      String id, dynamic token) async {
    Response response;
    ResponseModel<GetAllUserModel>? result;
    try {
      response = await get(
        Uri.parse('${api_url.users}/$id'),
        headers: config_json.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseModel<GetAllUserModel>.fromJson(json.decode(response.body));
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
        Uri.parse('${api_url.users}/service/$userId'),
        headers: config_json.headerAuth(token),
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

  Future<ResponseModel<UserBalanceModel>?> getUserBalance(
      String userId, dynamic token) async {
    Response response;
    ResponseModel<UserBalanceModel>? result;
    try {
      response = await get(
        Uri.parse('${api_url.users}/$userId/balance'),
        headers: config_json.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseModel<UserBalanceModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseModel<StatisticModel>?> getUserStatistic(dynamic token) async {
    Response response;
    ResponseModel<StatisticModel>? result;
    try {
      response = await get(
        Uri.parse('${api_url.users}/statistic'),
        headers: config_json.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseModel<StatisticModel>.fromJson(json.decode(response.body));
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
        Uri.parse('${api_url.users}/$userId/games?PageSize=50'),
        headers: config_json.headerAuth(token),
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

  Future<ResponseListModel<ImageModel>?> getImagesOfUser(
      String userId, dynamic token) async {
    Response response;
    ResponseListModel<ImageModel>? result;
    try {
      response = await get(
        Uri.parse('${api_url.users}/$userId/images'),
        headers: config_json.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseListModel<ImageModel>.fromJson(json.decode(response.body));
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
        Uri.parse('${api_url.users}/donates/$charityId'),
        headers: config_json.headerAuth(token),
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

  Future<bool?> updateIsPlayer(
      IsPlayerModel isPlayerModel, dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${api_url.users}/player'),
        headers: config_json.headerAuth(token),
        body: jsonEncode(isPlayerModel.toJson()),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> updatePersonalServiceInfo(
      ServiceUserModel serviceUserModel, dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${api_url.users}/service'),
        headers: config_json.headerAuth(token),
        body: jsonEncode(serviceUserModel.toJson()),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> checkBalance(dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${api_url.users}/un-active-balance'),
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

  Future<bool?> depositMoney(dynamic token, DepositModel depositModel) async {
    Response response;
    bool? result;
    try {
      response = await post(
        Uri.parse('${api_url.users}/deposit'),
        headers: config_json.headerAuth(token),
        body: jsonEncode(depositModel.toJson()),
      );
      if (response.statusCode == 200) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> withdrawMoney(
      dynamic token, WithdrawModel withdrawModel) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${api_url.users}/withdraw'),
        headers: config_json.headerAuth(token),
        body: jsonEncode(withdrawModel.toJson()),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseModel<MomoModel>?> getLinkMomo(
      MomoCreateModel momoCreateModel, dynamic token) async {
    Response response;
    ResponseModel<MomoModel>? result;
    try {
      response = await post(
        Uri.parse(api_url.momo),
        headers: config_json.headerAuth(token),
        body: jsonEncode(momoCreateModel.toJson()),
      );
      if (response.statusCode == 200) {
        result = ResponseModel<MomoModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<UnActiveBalanceModel>?> getListUnActiveBalance(
      dynamic token) async {
    Response response;
    ResponseListModel<UnActiveBalanceModel>? result;
    try {
      response = await get(
        Uri.parse(
            '${api_url.users}/un-active-balance?IsNew=true&isRelease=false'),
        headers: config_json.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseListModel<UnActiveBalanceModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
