import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
import 'package:play_together_mobile/models/recommend_model.dart';

class RecommendService {
  Future<List<ResultRecommendModel>?> predict(
      List<RecommendModel> recommendModel, dynamic token) async {
    Response response;
    List<ResultRecommendModel>? result;
    try {
      response = await post(
        Uri.parse(api_url.recommend),
        headers: config_json.header(),
        body: json.encoder.convert(recommendModel),
      );
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body
            .map((dynamic item) => ResultRecommendModel.fromJson(item))
            .toList();
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
