import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/report_model.dart';

class ReportService {
  Future<bool?> createReport(
      String orderId, dynamic token, ReportCreateModel model) async {
    Response response;
    bool? result;
    try {
      response = await post(
        Uri.parse('${apiUrl.reports}/$orderId'),
        headers: configJson.headerAuth(token),
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
