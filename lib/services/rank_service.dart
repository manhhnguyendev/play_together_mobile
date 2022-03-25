import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/rank_model.dart';

class RankService {
  Future<RankModel?> getRankById(String id, dynamic token) async {
    Response response;
    RankModel? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.ranks}/$id'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = RankModel.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
