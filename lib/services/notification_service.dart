import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
import 'package:play_together_mobile/models/notification_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';

class NotificationService {
  Future<ResponseListModel<NotificationModel>?> getNotifications(
      dynamic token, int pageSize) async {
    Response response;
    ResponseListModel<NotificationModel>? result;
    try {
      response = await get(
        Uri.parse('${api_url.notification}/?IsNew=true&PageSize=$pageSize'),
        headers: config_json.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseListModel<NotificationModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseModel<NotificationModel>?> getNotificationById(
      String id, dynamic token) async {
    Response response;
    ResponseModel<NotificationModel>? result;
    try {
      response = await get(
        Uri.parse('${api_url.notification}/$id'),
        headers: config_json.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseModel<NotificationModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
