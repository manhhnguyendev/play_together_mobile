import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as apiUrl;
import 'package:play_together_mobile/helpers/config_json.dart' as configJson;
import 'package:play_together_mobile/models/recommend_model.dart';

class RecommendService {
  Future<List<ResultRecommendModel>?> predict(
      List<RecommendModel> recommendModel, dynamic token) async {
    Response response;
    List<ResultRecommendModel>? result;
    try {
      response = await post(
        Uri.parse(apiUrl.recommend),
        headers: configJson.header(),
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
