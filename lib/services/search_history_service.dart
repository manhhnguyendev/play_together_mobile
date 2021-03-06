import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/search_history_model.dart';

class SearchHistoryService {
  Future<ResponseListModel<SearchHistoryModel>?> getSearchHistories(
      dynamic token) async {
    Response response;
    ResponseListModel<SearchHistoryModel>? result;
    try {
      response = await get(
        Uri.parse('${api_url.searchHistories}?IsNew=true&PageSize=5'),
        headers: config_json.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseListModel<SearchHistoryModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<SearchHistoryModel>?> getHotSearch(
      dynamic token) async {
    Response response;
    ResponseListModel<SearchHistoryModel>? result;
    try {
      response = await get(
        Uri.parse('${api_url.searchHistories}?IsHotSearch=true&PageSize=5'),
        headers: config_json.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseListModel<SearchHistoryModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
