import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/rating_comment_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';

class RatingService {
  Future<bool?> createRating(
      String orderId, dynamic token, RatingCreateModel model) async {
    Response response;
    bool? result;
    try {
      response = await post(
        Uri.parse('${apiUrl.ratings}/$orderId'),
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

  Future<ResponseListModel<RatingModel>?> getAllRating(
      String userId, double vote, dynamic token) async {
    Response response;
    ResponseListModel<RatingModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.ratings}/$userId?Vote=$vote&IsNew=true'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseListModel<RatingModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
