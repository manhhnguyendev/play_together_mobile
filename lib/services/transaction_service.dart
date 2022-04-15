import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as apiUrl;
import 'package:play_together_mobile/helpers/config_json.dart' as configJson;
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/transaction_model.dart';

class TransactionService {
  Future<ResponseListModel<TransactionModel>?> getAllTransaction(
      String type, String operation, dynamic token) async {
    Response response;
    ResponseListModel<TransactionModel>? result;
    try {
      response = await get(
        Uri.parse(
            '${apiUrl.users}/transactions?IsNew=true&Type=$type&Operation=$operation'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseListModel<TransactionModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
