import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
import 'package:play_together_mobile/models/report_model.dart';

class ReportService {
  Future<bool?> createReport(
      String orderId, dynamic token, ReportCreateModel model) async {
    Response response;
    bool? result;
    try {
      response = await post(
        Uri.parse('${api_url.reports}/$orderId'),
        headers: config_json.headerAuth(token),
        body: jsonEncode(model.toJson()),
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
