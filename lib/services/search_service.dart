import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
import 'package:play_together_mobile/models/charity_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/user_model.dart';

class SearchService {
  Future<ResponseListModel<GetAllUserModel>?> searchUser(
      String search, dynamic token, int pageSize) async {
    Response response;
    ResponseListModel<GetAllUserModel>? result;
    try {
      response = await get(
        Uri.parse(
            '${api_url.users}?Search=$search&IsPlayer=true&PageSize=$pageSize'),
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

  Future<ResponseListModel<GetAllUserModel>?> searchUserByFilter(
      String search,
      bool isMale,
      bool isFemale,
      String gameId,
      String status,
      bool sortByAlphabet,
      bool sortByRating,
      bool sortByHobby,
      bool sortByPrice,
      double startPrice,
      double endPrice,
      dynamic token) async {
    String gender = "";
    if (isMale && !isFemale) {
      gender = "true";
    } else if (!isMale && isFemale) {
      gender = "false";
    } else {
      gender = "";
    }
    Response response;
    ResponseListModel<GetAllUserModel>? result;
    try {
      response = await get(
        Uri.parse(
            '${api_url.users}?Search=$search&Gender=$gender&GameId=$gameId&Status=$status&IsOrderByName=$sortByAlphabet&IsOrderByRating=$sortByRating&IsOrderByPricing=$sortByPrice&IsSkillSameHobbies=$sortByHobby&IsPlayer=true&FromPrice=$startPrice&ToPrice=$endPrice'),
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

  Future<ResponseListModel<CharityModel>?> searchCharityByName(
      String search, dynamic token) async {
    Response response;
    ResponseListModel<CharityModel>? result;
    try {
      response = await get(
        Uri.parse('${api_url.charities}?Name=$search&IsActive=true'),
        headers: config_json.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseListModel<CharityModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
