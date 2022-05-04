import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as api_url;
import 'package:play_together_mobile/helpers/config_json.dart' as config_json;
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
        Uri.parse('${api_url.orders}/$id'),
        headers: config_json.headerAuth(token),
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
        Uri.parse('${api_url.orders}/detail/$orderId'),
        headers: config_json.headerAuth(token),
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
            '${api_url.users}/orders/requests?IsNew=true&PageSize=3&Status=$status'),
        headers: config_json.headerAuth(token),
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
            '${api_url.users}/orders/?IsNew=true&PageSize=3&Status=$status'),
        headers: config_json.headerAuth(token),
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
      dynamic token, int pageSize) async {
    Response response;
    ResponseListModel<OrderModel>? result;
    try {
      response = await get(
        Uri.parse('${api_url.users}/orders?IsNew=true&PageSize=$pageSize'),
        headers: config_json.headerAuth(token),
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
      dynamic token, int pageSize) async {
    Response response;
    ResponseListModel<OrderModel>? result;
    try {
      response = await get(
        Uri.parse(
            '${api_url.users}/orders/requests?IsNew=true&PageSize=$pageSize'),
        headers: config_json.headerAuth(token),
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
        Uri.parse('${api_url.users}/orders/$toUserId'),
        headers: config_json.headerAuth(token),
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

  Future<bool?> cancelOrderRequest(
      String orderId, dynamic token, CancelOrderModel cancelOrderModel) async {
    Response response;
    bool? result;
    try {
      response = await put(
        Uri.parse('${api_url.users}/orders/cancel/$orderId'),
        headers: config_json.headerAuth(token),
        body: jsonEncode(cancelOrderModel.toJson()),
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
        Uri.parse('${api_url.users}/orders/$orderId/process'),
        headers: config_json.headerAuth(token),
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
        Uri.parse('${api_url.users}/orders/$orderId/process'),
        headers: config_json.headerAuth(token),
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
        Uri.parse('${api_url.orders}/finish/$orderId'),
        headers: config_json.headerAuth(token),
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
        Uri.parse('${api_url.orders}/finish-soon/$orderId'),
        headers: config_json.headerAuth(token),
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
