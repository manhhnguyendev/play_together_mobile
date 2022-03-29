import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/rating_comment_model.dart';

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
      print(response.statusCode);
      if (response.statusCode == 200) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
