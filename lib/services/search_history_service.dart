import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/search_history_model.dart';

class SearchHistoryService {
  Future<List<SearchHistoryModel>?> getAllSearchHistories(dynamic token) async {
    Response response;
    List<SearchHistoryModel>? result;
    try {
      response = await get(
        Uri.parse(apiUrl.searchHistories),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body
            .map((dynamic item) => SearchHistoryModel.fromJson(item))
            .toList();
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
