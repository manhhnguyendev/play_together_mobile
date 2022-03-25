import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/order_model.dart';

class OrderService {
  Future<OrderModel?> getOrderById(String id, dynamic token) async {
    Response response;
    OrderModel? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.orders}/$id'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = OrderModel.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<OrderModel?> getAllOrdersForHirer(dynamic token) async {
    Response response;
    OrderModel? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}/orders'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = OrderModel.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<OrderModel?> getAllOrdersForPlayer(dynamic token) async {
    Response response;
    OrderModel? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}/orders/requests'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        result = OrderModel.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<CreateOrderModel?> createOrderRequest(
      String toUserId, CreateOrderModel createOrderModel, dynamic token) async {
    Response response;
    CreateOrderModel? result;
    try {
      response = await post(
        Uri.parse('${apiUrl.users}/orders/$toUserId'),
        headers: configJson.headerAuth(token),
        body: jsonEncode(createOrderModel.toJson()),
      );
      if (response.statusCode == 201) {
        result = CreateOrderModel.fromJson(json.decode(response.body));
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
        Uri.parse('${apiUrl.orders}/cancel/$orderId'),
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
}
