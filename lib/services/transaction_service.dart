import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/transaction_model.dart';

class TransactionService {
  Future<List<TransactionModel>?> getAllTransaction(dynamic token) async {
    Response response;
    List<TransactionModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}/transactions'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result = body
            .map((dynamic item) => TransactionModel.fromJson(item))
            .toList();
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}