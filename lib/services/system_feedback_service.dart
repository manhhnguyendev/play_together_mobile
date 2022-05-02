import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
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
        Uri.parse('${api_url.feedback}?IsNew=true&GetAll=true'),
        headers: config_json.headerAuth(token),
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
        Uri.parse('${api_url.feedback}/$feedbackId'),
        headers: config_json.headerAuth(token),
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
        Uri.parse(api_url.feedback),
        headers: config_json.headerAuth(token),
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
