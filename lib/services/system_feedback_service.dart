import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as apiUrl;
import 'package:play_together_mobile/helpers/config_json.dart' as configJson;
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';
import 'package:play_together_mobile/models/system_feedback_model.dart';

class SystemFeedbackService {
  Future<ResponseListModel<SystemFeedbackModel>?> getAllFeedbacks(
      String userId, dynamic token) async {
    Response response;
    ResponseListModel<SystemFeedbackModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.feedback}?IsNew=true&GetAll=true'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseListModel<SystemFeedbackModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseModel<SystemFeedbackDetailModel>?> getFeedbackDetail(
      String feedbackId, dynamic token) async {
    Response response;
    ResponseModel<SystemFeedbackDetailModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.feedback}/$feedbackId'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseModel<SystemFeedbackDetailModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> createFeedBacks(
      CreateFeedBacksModel createFeedBacksModel, dynamic token) async {
    Response response;
    bool? result = false;
    try {
      response = await post(
        Uri.parse(apiUrl.feedback),
        headers: configJson.headerAuth(token),
        body: json.encoder.convert(createFeedBacksModel),
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
