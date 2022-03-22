import 'package:play_together_mobile/models/game_model.dart';
import 'package:play_together_mobile/models/game_of_orders_model.dart';
import 'package:play_together_mobile/models/user_model.dart';

class OrderModel {
  String id;
  String userId;
  UserModel user;
  String toUserId;
  UserModel toUser;
  List<GameOfOrdersModel> gameOfOrderModel;
  String message;
  double totalTimes;
  double totalPrices;
  String status;
  String timeStart;
  String timeFinish;
  String processExpired;

  OrderModel({
    required this.id,
    required this.userId,
    required this.user,
    required this.toUserId,
    required this.toUser,
    required this.gameOfOrderModel,
    required this.message,
    required this.totalTimes,
    required this.totalPrices,
    required this.status,
    required this.timeStart,
    required this.timeFinish,
    required this.processExpired,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'] as String,
        userId: json['userId'] as String,
        user: (json['user']) != null
            ? UserModel.fromJson(json['user'])
            : UserModel.fromJson(json),
        toUserId: json['toUserId'] as String,
        toUser: (json['toUser']) != null
            ? UserModel.fromJson(json['toUser'])
            : UserModel.fromJson(json),
        gameOfOrderModel: (json['gameOfOrderModel'] as List<dynamic>?) != null
            ? (json['gameOfOrderModel'] as List<dynamic>)
                .map((balance) => GameOfOrdersModel.fromJson(balance))
                .toList()
            : <GameOfOrdersModel>[],
        message: json['message'] as String,
        totalTimes: json['totalTimes'] as double,
        totalPrices: json['totalPrices'] as double,
        status: json['status'] as String,
        timeStart: json['timeStart'] as String,
        timeFinish: json['timeFinish'] as String,
        processExpired: json['processExpired'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "user": user,
        "toUserId": toUserId,
        "toUser": toUser,
        "gameOfOrderModel": gameOfOrderModel,
        "message": message,
        "totalTimes": totalTimes,
        "totalPrices": totalPrices,
        "status": status,
        "timeStart": timeStart,
        "timeFinish": timeFinish,
        "processExpired": processExpired,
      };
}

class CreateOrderModel {
  double totalTimes;
  String message;
  List<GameModel> games;

  CreateOrderModel({
    required this.totalTimes,
    required this.message,
    required this.games,
  });
  factory CreateOrderModel.fromJson(Map<String, dynamic> json) =>
      CreateOrderModel(
        totalTimes: json['totalTimes'] as double,
        message: json['message'] as String,
        games: (json['games'] as List<dynamic>?) != null
            ? (json['games'] as List<dynamic>)
                .map((balance) => GameModel.fromJson(balance))
                .toList()
            : <GameModel>[],
      );

  Map<String, dynamic> toJson() => {
        "totalTimes": totalTimes,
        "message": message,
        "games": games,
      };
}
