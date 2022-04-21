import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as apiUrl;
import 'package:play_together_mobile/helpers/config_json.dart' as configJson;
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/response_list_model.dart';
import 'package:play_together_mobile/models/response_model.dart';

class OrderService {
  Future<ResponseModel<OrderModel>?> getOrderById(
      String id, dynamic token) async {
    Response response;
    ResponseModel<OrderModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.orders}/$id'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseModel<OrderModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseModel<OrderDetailModel>?> getDetailOrderById(
      String orderId, dynamic token) async {
    Response response;
    ResponseModel<OrderDetailModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.orders}/detail/$orderId'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = ResponseModel<OrderDetailModel>.fromJson(
            json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<OrderModel>?> getOrderOfPlayer(
      dynamic token, String status) async {
    Response response;
    ResponseListModel<OrderModel>? result;
    try {
      response = await get(
        Uri.parse(
            '${apiUrl.users}/orders/requests?IsNew=true&PageSize=3&Status=$status'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseListModel<OrderModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<OrderModel>?> getOrderOfUser(
      dynamic token, String status) async {
    Response response;
    ResponseListModel<OrderModel>? result;
    try {
      response = await get(
        Uri.parse(
            '${apiUrl.users}/orders/?IsNew=true&PageSize=3&Status=$status'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseListModel<OrderModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<OrderModel>?> getAllOrdersFromCreateUser(
      dynamic token) async {
    Response response;
    ResponseListModel<OrderModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}/orders?IsNew=true'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseListModel<OrderModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseListModel<OrderModel>?> getAllOrdersFromReceivedUser(
      dynamic token) async {
    Response response;
    ResponseListModel<OrderModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}/orders/requests?IsNew=true'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result =
            ResponseListModel<OrderModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseModel<OrderModel>?> createOrderRequest(
      String toUserId, CreateOrderModel createOrderModel, dynamic token) async {
    Response response;
    ResponseModel<OrderModel>? result;
    try {
      response = await post(
        Uri.parse('${apiUrl.users}/orders/$toUserId'),
        headers: configJson.headerAuth(token),
        body: jsonEncode(createOrderModel.toJson()),
      );
      if (response.statusCode == 201) {
        result = ResponseModel<OrderModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> cancelOrderRequest(String orderId, dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${apiUrl.users}/orders/cancel/$orderId'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> acceptOrderRequest(
      String orderId, dynamic token, AcceptOrderModel isAccept) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${apiUrl.users}/orders/$orderId/process'),
        headers: configJson.headerAuth(token),
        body: jsonEncode(isAccept.toJson()),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> rejectOrderRequest(
      String orderId, dynamic token, RejectOrderModel isAccept) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${apiUrl.users}/orders/$orderId/process'),
        headers: configJson.headerAuth(token),
        body: jsonEncode(isAccept.toJson()),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> finishOrder(String orderId, dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${apiUrl.orders}/finish/$orderId'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> finishSoonOrder(
      String orderId, dynamic token, FinishSoonOrderModel model) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${apiUrl.orders}/finish-soon/$orderId'),
        headers: configJson.headerAuth(token),
        body: jsonEncode(model.toJson()),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
