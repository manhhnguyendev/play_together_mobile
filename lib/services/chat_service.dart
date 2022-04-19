import 'package:play_together_mobile/helpers/api_url.dart' as apiUrl;
import 'package:play_together_mobile/helpers/config_json.dart' as configJson;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/models/chat_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';

class ChatService {
  Future<ResponseListModel<ChatModel>?> getAllChats(
      String userId, dynamic token) async {
    Response response;
    ResponseListModel<ChatModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.chat}/$userId?PageSize=10'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseListModel<ChatModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
