import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/transaction_model.dart';

class TransactionService {
  Future<ResponseListModel<TransactionModel>?> getAllTransaction(
      String type, String operation, dynamic token, int pageSize) async {
    Response response;
    ResponseListModel<TransactionModel>? result;
    try {
      response = await get(
        Uri.parse(
            '${api_url.users}/transactions?IsNew=true&Type=$type&Operation=$operation&PageSize=$pageSize'),
        headers: config_json.headerAuth(token),
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
