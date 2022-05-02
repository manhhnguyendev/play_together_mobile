import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/models/chat_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';

class ChatService {
  Future<ResponseListModel<ChatModel>?> getAllChats(
      String receiveId, dynamic token) async {
    Response response;
    ResponseListModel<ChatModel>? result;
    try {
      response = await get(
        Uri.parse('${api_url.chat}/$receiveId'),
        headers: config_json.headerAuth(token),
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

  Future<bool?> createChat(String receiveId, SendMessageModel sendMessageModel,
      dynamic token) async {
    Response response;
    bool? result = false;
    try {
      response = await post(
        Uri.parse('${api_url.chat}/$receiveId'),
        headers: config_json.headerAuth(token),
        body: json.encoder.convert(sendMessageModel),
      );
      if (response.statusCode == 200) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
